Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD1341C2A3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Sep 2021 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245445AbhI2KWg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Sep 2021 06:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245409AbhI2KWg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Sep 2021 06:22:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E5EC06161C;
        Wed, 29 Sep 2021 03:20:55 -0700 (PDT)
Date:   Wed, 29 Sep 2021 10:20:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632910853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JD18OWrCG0akH/94tz8b+5n/5Jxz+1yvoBP7h17+jtE=;
        b=y33vN97nvNv7IfcFikah9vm3xAsU0r6m+7eEkZFm34UPi36QtuL8qEAGrJJYGHRs0xwOCz
        w1sUlC6gmOgxlqDES1kNASoDAz1B5O8R7zgY1G9KDAYHEZjoVSquwCleMP8Yc0sYIqGCP+
        E3OX5MWqS1T8RwYrUoN76NzXiu+D9uuiFFj9oNhHMhCTdx8hv7Esep8R4s2iNqaGxp03Af
        2TIVaj1h8NuqDssHJHV8KCUM97Jj8JiQHd143fmQANwn4S8EdWPs47cqd9jppGKMuHcusm
        Xwtcj3S0wtRcEDpI/llwIgdx4e83eug6Cqvjfgy3rvvI2H5iYJDftezxgWrQmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632910853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JD18OWrCG0akH/94tz8b+5n/5Jxz+1yvoBP7h17+jtE=;
        b=9Zb7f5ayYblMr51WUjSXL+AsyIeHg6J421yH3DIWl7mc9LXWYZeQjXk0/kW0p/EkRKxdDm
        DUkDIAxxc7rMlzBQ==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/boot: Fix make hdimage with older versions of mtools
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210911003906.2700218-1-hpa@zytor.com>
References: <20210911003906.2700218-1-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <163291085263.25758.9352348895398432135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     067595d728179219c120dd50b4dc711e92f1eb16
Gitweb:        https://git.kernel.org/tip/067595d728179219c120dd50b4dc711e92f1eb16
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Fri, 10 Sep 2021 17:39:06 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 29 Sep 2021 11:06:47 +02:00

x86/boot: Fix make hdimage with older versions of mtools

Some versions of mtools (fixed somewhere between 4.0.31 and 4.0.35)
generate bad output for mformat when used with the partition= option.
Use the offset= option instead. An mtools.conf entry is *also* needed
with partition= to support mpartition; combining them in one entry does
not work either.

Don't specify the -t option to mpartition; it is unnecessary and seems
to confuse mpartition under some circumstances.

Also do a few minor optimizations:

Use a larger cluster size; there is no reason for the typical 4K
clusters when we are dealing mainly with comparatively huge files.

Start the partition at 32K. There is no reason to align it more than
that, since the internal FAT filesystem structures will at best be
cluster-aligned, and 32K is the maximum FAT cluster size.

 [ bp: Remove "we". ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210911003906.2700218-1-hpa@zytor.com
---
 arch/x86/boot/genimage.sh    | 15 ++++++++-------
 arch/x86/boot/mtools.conf.in |  5 +++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/genimage.sh b/arch/x86/boot/genimage.sh
index 0673fdf..c9299ae 100644
--- a/arch/x86/boot/genimage.sh
+++ b/arch/x86/boot/genimage.sh
@@ -120,12 +120,13 @@ efiarch() {
 }
 
 # Get the combined sizes in bytes of the files given, counting sparse
-# files as full length, and padding each file to a 4K block size
+# files as full length, and padding each file to cluster size
+cluster=16384
 filesizes() {
 	local t=0
 	local s
 	for s in $(ls -lnL "$@" 2>/dev/null | awk '/^-/{ print $5; }'); do
-		t=$((t + ((s+4095)/4096)*4096))
+		t=$((t + ((s+cluster-1)/cluster)*cluster))
 	done
 	echo $t
 }
@@ -230,14 +231,14 @@ genhdimage() {
 		ptype='-T 0xef'	# EFI system partition, no GPT
 	fi
 	sizes=$(filesizes "$FBZIMAGE" "${FDINITRDS[@]}" "$efishell")
-	# Allow 1% + 1 MiB for filesystem and partition table overhead,
-	# syslinux, and config files
+	# Allow 1% + 2 MiB for filesystem and partition table overhead,
+	# syslinux, and config files; this is probably excessive...
 	megs=$(((sizes + sizes/100 + 2*1024*1024 - 1)/(1024*1024)))
 	$dd if=/dev/zero of="$FIMAGE" bs=$((1024*1024)) count=$megs 2>/dev/null
-	mpartition -I -c -s 32 -h 64 -t $megs $ptype -b 512 -a h:
+	mpartition -I -c -s 32 -h 64 $ptype -b 64 -a p:
 	$dd if="$mbr" of="$FIMAGE" bs=440 count=1 conv=notrunc 2>/dev/null
-	mformat -v 'LINUX_BOOT' -s 32 -h 64 -t $megs h:
-	syslinux --offset $((512*512)) "$FIMAGE"
+	mformat -v 'LINUX_BOOT' -s 32 -h 64 -c $((cluster/512)) -t $megs h:
+	syslinux --offset $((64*512)) "$FIMAGE"
 	do_mcopy h:
 }
 
diff --git a/arch/x86/boot/mtools.conf.in b/arch/x86/boot/mtools.conf.in
index 9e2662d..174c605 100644
--- a/arch/x86/boot/mtools.conf.in
+++ b/arch/x86/boot/mtools.conf.in
@@ -14,7 +14,8 @@ drive v:
 drive w:
   file="@OBJ@/fdimage" cylinders=80 heads=2 sectors=36 filter
 
-# Hard disk
+# Hard disk (h: for the filesystem, p: for format - old mtools bug?)
 drive h:
+  file="@OBJ@/hdimage" offset=32768 mformat_only
+drive p:
   file="@OBJ@/hdimage" partition=1 mformat_only
-
