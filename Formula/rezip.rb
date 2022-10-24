class Rezip < Formula
  desc "Git clean filter to output uncompressed zip files for better packing"
  homepage "https://github.com/costerwi/rezip"
  url "https://github.com/costerwi/rezip/archive/v1.0.0.tar.gz"
  sha256 "3684a3d7e6bc13cfb01df8310ee89951ac9836ca653d71229faa64524bcb6bf0"
  license "Apache-2.0"

  depends_on "openjdk" => :build

  def install
    rm Dir["*.class"]

    ENV["JAVA_HOME"] = Formula["openjdk"].opt_prefix
    system "#{Formula["openjdk"].bin}/javac", "ReZip.java"

    libexec.install "ReZip.class"
    (bin/"rezip").write <<~EOS
      #!/bin/bash
      export JAVA_HOME="${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
      exec "${JAVA_HOME}/bin/java" -cp "#{libexec}" ReZip "$@"
    EOS
  end

  def caveats
    <<~EOS
      To configure the clean and smudge filters, run:
        git config --global --replace-all filter.rezip.clean "#{opt_bin}/rezip --store"
        git config --global --add filter.rezip.smudge "#{opt_bin}/rezip"
    EOS
  end

  test do
    mkdir testpath/"repo" do
      system "git", "config", "--global", "--replace-all", "filter.rezip.clean", "#{opt_bin}/rezip --store"
      system "git", "config", "--global", "--replace-all", "filter.rezip.smudge", "#{opt_bin}/rezip"

      system "git", "init"
      system "git", "config", "--add", "--bool", "merge.renormalize", "true"

      (Pathname.pwd/".gitattributes").write <<~EOS
        *.zip filter=rezip
      EOS

      system "git", "add", "-A"
      system "git", "commit", ".gitattributes", "-m", "add `.gitattributes` file"

      (Pathname.pwd/"foo").write "Hello Hello Hello"
      system "zip", "foo.zip", "foo"
      rm "foo"

      system "git", "add", "-A"
      system "git", "commit", "-m", "add `foo` file"

      foo_obj_id = shell_output("git rev-parse :foo.zip").chop
      assert_includes shell_output("git cat-file blob #{foo_obj_id}"), "Hello Hello Hello"

      assert (Pathname.pwd/"foo.zip").read.exclude?("Hello Hello Hello")

      rm "foo.zip"
      system "git", "checkout", "-f", "HEAD"

      system "unzip", "foo.zip"
      assert !(Pathname.pwd/"foo.zip").read.equal?("Hello Hello Hello")
    end
  end
end
