Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1C4181A6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Sep 2021 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhIYLcv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Sep 2021 07:32:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46636 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhIYLcu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Sep 2021 07:32:50 -0400
Date:   Sat, 25 Sep 2021 11:31:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632569474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkG1RbVWYKVnLnWbroKZY4D6SgQ0oBEKHZi9Yk1Ax5c=;
        b=oRB9r3hItnZZ01S72Hb26oFeNs60B5JB0vU8dUIlgwPqd2iwG1cUy3xxG1POpUD/GLqc29
        xjOP94Kkda5z0DxmxNBcAYMS+zEPoUY7Sk5809uukjtupzdqzx2l/z+bTYSBHcq8bbndD8
        iBMRA5VRo0cddyWiMxapcuMMEiDHjf60q9hz0ojLn+hZtk9qUZU2OFxUf9YVMQ59cf3Lt/
        eq0XEIEH1g2pJO7tfsiOnUwbF8cIU45diB12ZltpikD+VutpBhTe6GYZyW1EusOcmDp8Q6
        UxksGFzscFTmgO3el5AVlQgn2CcwJTWy4RGO3OF+5G2mPEizoTZ5jcNkWLTm1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632569474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkG1RbVWYKVnLnWbroKZY4D6SgQ0oBEKHZi9Yk1Ax5c=;
        b=fyr38wA6QMUC0ZGmNypDI5hnOjVaGcgBSEC3wJWlqM22kxaug0+ZuwElNJGNuKKlvlnQgp
        dWsqpbHnaKdpGAAw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/umip: Downgrade warning messages to debug loglevel
Cc:     mrueckert@suse.com, Borislav Petkov <bp@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210907200454.30458-1-bp@alien8.de>
References: <20210907200454.30458-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163256947294.25758.18286750023731125992.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f3f07ae425bc09039d9e0c73c86b76f95d9d5cd6
Gitweb:        https://git.kernel.org/tip/f3f07ae425bc09039d9e0c73c86b76f95d9=
d5cd6
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 15 Sep 2021 16:39:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 25 Sep 2021 13:23:28 +02:00

x86/umip: Downgrade warning messages to debug loglevel

After four years in the wild, those have not fullfilled their
initial purpose of pushing people to fix their software to not use
UMIP-emulated instructions, and to warn users about the degraded
emulation performance.

Yet, the only thing that "degrades" performance is overflowing dmesg
with those:

  [Di Sep  7 00:24:05 2021] umip_printk: 1345 callbacks suppressed
  [Di Sep  7 00:24:05 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b7c0: =
SIDT instruction cannot be used by applications.
  [Di Sep  7 00:24:05 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b7c0: =
For now, expensive software emulation returns the result.
  ...
  [Di Sep  7 00:26:06 2021] umip_printk: 2227 callbacks suppressed
  [Di Sep  7 00:26:06 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b940: =
SIDT instruction cannot be used by applications.

and users don't really care about that - they just want to play their
games in wine.

So convert those to debug loglevel - in case someone is still interested
in them, someone can boot with "debug" on the kernel cmdline.

Reported-by: Marcus R=C3=BCckert <mrueckert@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://lkml.kernel.org/r/20210907200454.30458-1-bp@alien8.de
---
 arch/x86/kernel/umip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 576b47e..5a4b213 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -92,8 +92,8 @@ static const char * const umip_insns[5] =3D {
=20
 #define umip_pr_err(regs, fmt, ...) \
 	umip_printk(regs, KERN_ERR, fmt, ##__VA_ARGS__)
-#define umip_pr_warn(regs, fmt, ...) \
-	umip_printk(regs, KERN_WARNING, fmt,  ##__VA_ARGS__)
+#define umip_pr_debug(regs, fmt, ...) \
+	umip_printk(regs, KERN_DEBUG, fmt,  ##__VA_ARGS__)
=20
 /**
  * umip_printk() - Print a rate-limited message
@@ -361,10 +361,10 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	if (umip_inst < 0)
 		return false;
=20
-	umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
+	umip_pr_debug(regs, "%s instruction cannot be used by applications.\n",
 			umip_insns[umip_inst]);
=20
-	umip_pr_warn(regs, "For now, expensive software emulation returns the resul=
t.\n");
+	umip_pr_debug(regs, "For now, expensive software emulation returns the resu=
lt.\n");
=20
 	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
 			      user_64bit_mode(regs)))
