Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB90B3EA2D4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 12:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhHLKMF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 06:12:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbhHLKKR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 06:10:17 -0400
Date:   Thu, 12 Aug 2021 10:09:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628762983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1prOnd7axUVldLY2mifFmYzGUM3E1GP8R1mRkSrx2k=;
        b=ft34FX+GWEVJuF60uRseYJuywJ2S6GzVKhH+57FAcq2gMvPuHMrF860r1t4s3jAqc5ULFI
        0o5ojfJPSGL0hPBtjahE+gLl9lnaXlxghw1A7hCslatp4ubykCvvqLrsyLgr9SVxgzftfs
        PZ+sla13zgDAn+cMDnCyIU29J5RYCSOC++Aqx1WOMaVylXpmLWICr9qyGtpx5MKJSNocSX
        ypZr119qMy7MTwyloKjYX0NM0CukPoXeMm19rlXXwgSIXfveJ06cJFBuwleZsHT5mJ6sd8
        rpoZWqipUyM5ERiV3fE9na8eCQBjP09Lv5VFf+sV3+mQYLxxaHQ4uX0KLErnCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628762983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1prOnd7axUVldLY2mifFmYzGUM3E1GP8R1mRkSrx2k=;
        b=mxeOvvm19F4ayrF16JRS16E5ndC4WYrLGlDvYBYqSS0b+zchaQlDuhE/VIniGU0nNarIvh
        JdgsNvqWJnfLzRCw==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/reboot: Document how to override DMI platform quirks
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210530162447.996461-3-paul.gortmaker@windriver.com>
References: <20210530162447.996461-3-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Message-ID: <162876298304.395.8685197228455259421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     12febc181886f0658ce3413f554203c255d338dd
Gitweb:        https://git.kernel.org/tip/12febc181886f0658ce3413f554203c255d338dd
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 30 May 2021 12:24:46 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 12 Aug 2021 12:06:58 +02:00

x86/reboot: Document how to override DMI platform quirks

commit 5955633e91bf ("x86/reboot: Skip DMI checks if reboot set by user")
made it so that it's not required to recompile the kernel in order to
bypass broken reboot quirks compiled into an image:

 * This variable is used privately to keep track of whether or not
 * reboot_type is still set to its default value (i.e., reboot= hasn't
 * been set on the command line).  This is needed so that we can
 * suppress DMI scanning for reboot quirks.  Without it, it's
 * impossible to override a faulty reboot quirk without recompiling.

However, at the time it was not eally documented outside the source code,
and so this information isn't really available to the average user out
there.

The change is a little white lie and invented "reboot=default" since it is
easy to remember, and documents well.  The truth is that any random string
that is *not* a currently accepted string will work.

Since that doesn't document well for non-coders, and since it's unknown
what the future additions might be, lay claim on "default" since that is
exactly what it achieves.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210530162447.996461-3-paul.gortmaker@windriver.com

---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/x86/x86_64/boot-options.rst       | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb2200..34c8dd5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4777,7 +4777,7 @@
 
 	reboot=		[KNL]
 			Format (x86 or x86_64):
-				[w[arm] | c[old] | h[ard] | s[oft] | g[pio]] \
+				[w[arm] | c[old] | h[ard] | s[oft] | g[pio]] | d[efault] \
 				[[,]s[mp]#### \
 				[[,]b[ios] | a[cpi] | k[bd] | t[riple] | e[fi] | p[ci]] \
 				[[,]f[orce]
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 482f3b2..ccb7e86 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -157,6 +157,13 @@ Rebooting
      Don't stop other CPUs on reboot. This can make reboot more reliable
      in some cases.
 
+   reboot=default
+     There are some built-in platform specific "quirks" - you may see:
+     "reboot: <name> series board detected. Selecting <type> for reboots."
+     In the case where you think the quirk is in error (e.g. you have
+     newer BIOS, or newer board) using this option will ignore the built-in
+     quirk table, and use the generic default reboot actions.
+
 Non Executable Mappings
 =======================
 
