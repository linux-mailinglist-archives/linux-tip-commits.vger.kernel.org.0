Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5022342056
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 15:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCSO61 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 10:58:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56420 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhCSO6K (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 10:58:10 -0400
Received: from zn.tnic (p200300ec2f091e0035ab8ae551405c9b.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1e00:35ab:8ae5:5140:5c9b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 366131EC027A;
        Fri, 19 Mar 2021 15:58:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616165889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iuimkE8hnuyAWPRRvF4BeQ9cNaIgtl3BXo5mh7Z2PJM=;
        b=rpeLzLQlKJY8BRO6M70dZ8LrsJFFmmD/35kjEHcq9fM7AslRb+EZMY1NfyYr1u8ttT/G/k
        EsnHOmsQMl80fqN394X2G/T4OOMZzX3IX3ywi9WNnQrTf/Rjo5L2wB7nocZ/yQIFIGPYbf
        XsKo5MrAGO4GUwzTYWA9LTXPDOCw/60=
Date:   Fri, 19 Mar 2021 15:58:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/sgx] selftests/sgx: Improve error detection and
 messages
Message-ID: <20210319145807.GG6251@zn.tnic>
References: <20210318194301.11D9A984@viggo.jf.intel.com>
 <161615392429.398.565615269339667317.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161615392429.398.565615269339667317.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Mar 19, 2021 at 11:38:44AM -0000, tip-bot2 for Dave Hansen wrote:
>  tools/testing/selftests/sgx/load.c | 66 ++++++++++++++++++++++-------
>  tools/testing/selftests/sgx/main.c |  2 +-
>  2 files changed, 53 insertions(+), 15 deletions(-)

Anything against some more tweaks ontop?

---
diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 4c149f46d798..f441ac34b4d4 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -156,7 +156,7 @@ bool encl_load(const char *path, struct encl *encl)
 	 * the owner or in the owning group.
 	 */
 	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) {
-		fprintf(stderr, "no execute permissions on device file\n");
+		fprintf(stderr, "no execute permissions on device file %s\n", device_path);
 		goto err;
 	}
 
@@ -167,12 +167,15 @@ bool encl_load(const char *path, struct encl *encl)
 	}
 	munmap(ptr, PAGE_SIZE);
 
+#define ERR_MSG \
+"mmap() succeeded for PROT_READ, but failed for PROT_EXEC.\n" \
+" Check that current user has execute permissions on %s and \n" \
+" that /dev does not have noexec set: mount | grep \"/dev .*noexec\"\n" \
+" If so, remount it executable: mount -o remount,exec /dev\n\n"
+
 	ptr = mmap(NULL, PAGE_SIZE, PROT_EXEC, MAP_SHARED, fd, 0);
 	if (ptr == (void *)-1) {
-		perror("ERROR: mmap for exec");
-		fprintf(stderr, "mmap() succeeded for PROT_READ, but failed for PROT_EXEC\n");
-		fprintf(stderr, "check that user has execute permissions on %s and\n", device_path);
-		fprintf(stderr, "that /dev does not have noexec set: 'mount | grep \"/dev .*noexec\"'\n");
+		fprintf(stderr, ERR_MSG, device_path);
 		goto err;
 	}
 	munmap(ptr, PAGE_SIZE);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
