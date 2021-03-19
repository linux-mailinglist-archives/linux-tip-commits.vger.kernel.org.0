Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB8341BA0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 12:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCSLjD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 07:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhCSLis (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 07:38:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59006C06174A;
        Fri, 19 Mar 2021 04:38:48 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:38:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616153925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+T5iOVTYhacZn3Evj8VuILZDx8ho4wrapEuGDvxO80k=;
        b=Q439dtSAkIBgaDvm0vNQvME8Hpyo9AHLAcUMhrFebOQlG6eRvrKV9+OTde8QbfzDewt7lZ
        eshsHt5HE4BEIwKZ3815pUxmiGtp0yI1GwKF3HZJ1moULZaL6Q/I/aX9SC2bfUsQC0iXea
        FsfmRs09QY+Tcs7mT0rC9IZKelQ+CcI5EzHb1cOVKQTH8kiy6aPHmj1iSEFTkaREx18nBL
        pQ4yQCJic8BoprffGa99nabOYmHX70vz+my3XlhR2xSmxjNwRb3y6szjJj5I52Q3U+s5tQ
        7ZLv8Tjsnboj6EmDXZsqys0p5DFRR8MCSOS9Hr0K1EWvqkuRvc6ELOe5e5KHBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616153925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+T5iOVTYhacZn3Evj8VuILZDx8ho4wrapEuGDvxO80k=;
        b=RwdEXEeavVxUqxm4yv3C1WNpzqr8zOYi0Qik+HDIr8WtbIe72IIqv4JxQGDv/HyZZj6zpQ
        ge7GGZ9FkZUM3cDg==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Improve error detection and messages
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210318194301.11D9A984@viggo.jf.intel.com>
References: <20210318194301.11D9A984@viggo.jf.intel.com>
MIME-Version: 1.0
Message-ID: <161615392429.398.565615269339667317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     79713a1fa1b9cd9d650b1ff0657ddbadc5dbbeaa
Gitweb:        https://git.kernel.org/tip/79713a1fa1b9cd9d650b1ff0657ddbadc5dbbeaa
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Thu, 18 Mar 2021 12:43:01 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 19 Mar 2021 12:18:21 +01:00

selftests/sgx: Improve error detection and messages

The SGX device file (/dev/sgx_enclave) is unusual in that it requires
execute permissions.  It has to be both "chmod +x" *and* be on a
filesystem without 'noexec'.

In the future, udev and systemd should get updates to set up systems
automatically.  But, for now, nobody's systems do this automatically,
and everybody gets error messages like this when running ./test_sgx:

	0x0000000000000000 0x0000000000002000 0x03
	0x0000000000002000 0x0000000000001000 0x05
	0x0000000000003000 0x0000000000003000 0x03
	mmap() failed, errno=1.

That isn't very user friendly, even for forgetful kernel developers.

Further, the test case is rather haphazard about its use of fprintf()
versus perror().

Improve the error messages.  Use perror() where possible.  Lastly,
do some sanity checks on opening and mmap()ing the device file so
that we can get a decent error message out to the user.

Now, if your user doesn't have permission, you'll get the following:

	$ ls -l /dev/sgx_enclave
	crw------- 1 root root 10, 126 Mar 18 11:29 /dev/sgx_enclave
	$ ./test_sgx
	Unable to open /dev/sgx_enclave: Permission denied

If you then 'chown dave:dave /dev/sgx_enclave' (or whatever), but
you leave execute permissions off, you'll get:

	$ ls -l /dev/sgx_enclave
	crw------- 1 dave dave 10, 126 Mar 18 11:29 /dev/sgx_enclave
	$ ./test_sgx
	no execute permissions on device file

If you fix that with "chmod ug+x /dev/sgx" but you leave /dev as
noexec, you'll get this:

	$ mount | grep "/dev .*noexec"
	udev on /dev type devtmpfs (rw,nosuid,noexec,...)
	$ ./test_sgx
	ERROR: mmap for exec: Operation not permitted
	mmap() succeeded for PROT_READ, but failed for PROT_EXEC
	check that user has execute permissions on /dev/sgx_enclave and
	that /dev does not have noexec set: 'mount | grep "/dev .*noexec"'

That can be fixed with:

	mount -o remount,noexec /devESC

Hopefully, the combination of better error messages and the search
engines indexing this message will help people fix their systems
until we do this properly.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20210318194301.11D9A984@viggo.jf.intel.com
---
 tools/testing/selftests/sgx/load.c | 66 ++++++++++++++++++++++-------
 tools/testing/selftests/sgx/main.c |  2 +-
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 9d43b75..4c149f4 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -45,19 +45,19 @@ static bool encl_map_bin(const char *path, struct encl *encl)
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)  {
-		perror("open()");
+		perror("enclave executable open()");
 		return false;
 	}
 
 	ret = stat(path, &sb);
 	if (ret) {
-		perror("stat()");
+		perror("enclave executable stat()");
 		goto err;
 	}
 
 	bin = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (bin == MAP_FAILED) {
-		perror("mmap()");
+		perror("enclave executable mmap()");
 		goto err;
 	}
 
@@ -90,8 +90,7 @@ static bool encl_ioc_create(struct encl *encl)
 	ioc.src = (unsigned long)secs;
 	rc = ioctl(encl->fd, SGX_IOC_ENCLAVE_CREATE, &ioc);
 	if (rc) {
-		fprintf(stderr, "SGX_IOC_ENCLAVE_CREATE failed: errno=%d\n",
-			errno);
+		perror("SGX_IOC_ENCLAVE_CREATE failed");
 		munmap((void *)secs->base, encl->encl_size);
 		return false;
 	}
@@ -116,31 +115,69 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
 
 	rc = ioctl(encl->fd, SGX_IOC_ENCLAVE_ADD_PAGES, &ioc);
 	if (rc < 0) {
-		fprintf(stderr, "SGX_IOC_ENCLAVE_ADD_PAGES failed: errno=%d.\n",
-			errno);
+		perror("SGX_IOC_ENCLAVE_ADD_PAGES failed");
 		return false;
 	}
 
 	return true;
 }
 
+
+
 bool encl_load(const char *path, struct encl *encl)
 {
+	const char device_path[] = "/dev/sgx_enclave";
 	Elf64_Phdr *phdr_tbl;
 	off_t src_offset;
 	Elf64_Ehdr *ehdr;
+	struct stat sb;
+	void *ptr;
 	int i, j;
 	int ret;
+	int fd = -1;
 
 	memset(encl, 0, sizeof(*encl));
 
-	ret = open("/dev/sgx_enclave", O_RDWR);
-	if (ret < 0) {
-		fprintf(stderr, "Unable to open /dev/sgx_enclave\n");
+	fd = open(device_path, O_RDWR);
+	if (fd < 0) {
+		perror("Unable to open /dev/sgx_enclave");
+		goto err;
+	}
+
+	ret = stat(device_path, &sb);
+	if (ret) {
+		perror("device file stat()");
+		goto err;
+	}
+
+	/*
+	 * This just checks if the /dev file has these permission
+	 * bits set.  It does not check that the current user is
+	 * the owner or in the owning group.
+	 */
+	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) {
+		fprintf(stderr, "no execute permissions on device file\n");
+		goto err;
+	}
+
+	ptr = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
+	if (ptr == (void *)-1) {
+		perror("mmap for read");
+		goto err;
+	}
+	munmap(ptr, PAGE_SIZE);
+
+	ptr = mmap(NULL, PAGE_SIZE, PROT_EXEC, MAP_SHARED, fd, 0);
+	if (ptr == (void *)-1) {
+		perror("ERROR: mmap for exec");
+		fprintf(stderr, "mmap() succeeded for PROT_READ, but failed for PROT_EXEC\n");
+		fprintf(stderr, "check that user has execute permissions on %s and\n", device_path);
+		fprintf(stderr, "that /dev does not have noexec set: 'mount | grep \"/dev .*noexec\"'\n");
 		goto err;
 	}
+	munmap(ptr, PAGE_SIZE);
 
-	encl->fd = ret;
+	encl->fd = fd;
 
 	if (!encl_map_bin(path, encl))
 		goto err;
@@ -217,6 +254,8 @@ bool encl_load(const char *path, struct encl *encl)
 	return true;
 
 err:
+	if (fd != -1)
+		close(fd);
 	encl_delete(encl);
 	return false;
 }
@@ -229,7 +268,7 @@ static bool encl_map_area(struct encl *encl)
 	area = mmap(NULL, encl_size * 2, PROT_NONE,
 		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (area == MAP_FAILED) {
-		perror("mmap");
+		perror("reservation mmap()");
 		return false;
 	}
 
@@ -268,8 +307,7 @@ bool encl_build(struct encl *encl)
 	ioc.sigstruct = (uint64_t)&encl->sigstruct;
 	ret = ioctl(encl->fd, SGX_IOC_ENCLAVE_INIT, &ioc);
 	if (ret) {
-		fprintf(stderr, "SGX_IOC_ENCLAVE_INIT failed: errno=%d\n",
-			errno);
+		perror("SGX_IOC_ENCLAVE_INIT failed");
 		return false;
 	}
 
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 724cec7..b117bb8 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -195,7 +195,7 @@ int main(int argc, char *argv[], char *envp[])
 		addr = mmap((void *)encl.encl_base + seg->offset, seg->size,
 			    seg->prot, MAP_SHARED | MAP_FIXED, encl.fd, 0);
 		if (addr == MAP_FAILED) {
-			fprintf(stderr, "mmap() failed, errno=%d.\n", errno);
+			perror("mmap() segment failed");
 			exit(KSFT_FAIL);
 		}
 	}
