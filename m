Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0570E8A66F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Aug 2019 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfHLSkx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Aug 2019 14:40:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfHLSkx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Aug 2019 14:40:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CIemZg1022921
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 11:40:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CIemZg1022921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565635248;
        bh=vR+7oAGgdlBJzKNfw/xyAWL1/cHTwcJZlEPCGcVL/rk=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=MJdZxScra7ZnduTjLWnBfegM7YE1QKMzRwNqt6+5DY9BpcBW10aD50lSD02YjXMYB
         S8UwgPSJ+aWkv027Qc/Ui9CnH84VVHsZccF5KhXP77tsTV8gp03X//ixgQ3346LWQ+
         buYHiVyGOsFHkO6He3TFDIKwzJqI7P9XRvuWe7OvFQYeTN56ETnbKqwGp4Qb846Amk
         eawLp/O6Q555hkrvbBSRlfxn0Hm2dWgjtenADrLRIljhxAV2HaJJAHcPTm9zlBu+DS
         E+dynBpgEd/NWZA76mhpcHBzVGlpHUuIMD4useJlyfeVnSamxT73zRBcPVMX8fyiV9
         lCOraemgttZnA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CIelaQ1022918;
        Mon, 12 Aug 2019 11:40:47 -0700
Date:   Mon, 12 Aug 2019 11:40:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-91be2587e82a0f16348fd8f12a57e4c328baffc7@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/fpu/math-emu: Address fallthrough warnings
Git-Commit-ID: 91be2587e82a0f16348fd8f12a57e4c328baffc7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  91be2587e82a0f16348fd8f12a57e4c328baffc7
Gitweb:     https://git.kernel.org/tip/91be2587e82a0f16348fd8f12a57e4c328baffc7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 12 Aug 2019 20:16:17 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 12 Aug 2019 20:35:05 +0200

x86/fpu/math-emu: Address fallthrough warnings

/home/tglx/work/kernel/linus/linux/arch/x86/math-emu/errors.c: In function ‘FPU_printall’:
/home/tglx/work/kernel/linus/linux/arch/x86/math-emu/errors.c:187:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
    tagi = FPU_Special(r);
    ~~~~~^~~~~~~~~~~~~~~~
/home/tglx/work/kernel/linus/linux/arch/x86/math-emu/errors.c:188:3: note: here
   case TAG_Valid:
   ^~~~
/home/tglx/work/kernel/linus/linux/arch/x86/math-emu/fpu_trig.c: In function ‘fyl2xp1’:
/home/tglx/work/kernel/linus/linux/arch/x86/math-emu/fpu_trig.c:1353:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (denormal_operand() < 0)
       ^
/home/tglx/work/kernel/linus/linux/arch/x86/math-emu/fpu_trig.c:1356:3: note: here
   case TAG_Zero:

Remove the pointless 'break;' after 'continue;' while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/math-emu/errors.c   | 5 +++--
 arch/x86/math-emu/fpu_trig.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/math-emu/errors.c b/arch/x86/math-emu/errors.c
index 6b468517ab71..73dc66d887f3 100644
--- a/arch/x86/math-emu/errors.c
+++ b/arch/x86/math-emu/errors.c
@@ -178,13 +178,15 @@ void FPU_printall(void)
 	for (i = 0; i < 8; i++) {
 		FPU_REG *r = &st(i);
 		u_char tagi = FPU_gettagi(i);
+
 		switch (tagi) {
 		case TAG_Empty:
 			continue;
-			break;
 		case TAG_Zero:
 		case TAG_Special:
+			/* Update tagi for the printk below */
 			tagi = FPU_Special(r);
+			/* fall through */
 		case TAG_Valid:
 			printk("st(%d)  %c .%04lx %04lx %04lx %04lx e%+-6d ", i,
 			       getsign(r) ? '-' : '+',
@@ -198,7 +200,6 @@ void FPU_printall(void)
 			printk("Whoops! Error in errors.c: tag%d is %d ", i,
 			       tagi);
 			continue;
-			break;
 		}
 		printk("%s\n", tag_desc[(int)(unsigned)tagi]);
 	}
diff --git a/arch/x86/math-emu/fpu_trig.c b/arch/x86/math-emu/fpu_trig.c
index 783c509f957a..127ea54122d7 100644
--- a/arch/x86/math-emu/fpu_trig.c
+++ b/arch/x86/math-emu/fpu_trig.c
@@ -1352,7 +1352,7 @@ static void fyl2xp1(FPU_REG *st0_ptr, u_char st0_tag)
 		case TW_Denormal:
 			if (denormal_operand() < 0)
 				return;
-
+			/* fall through */
 		case TAG_Zero:
 		case TAG_Valid:
 			setsign(st0_ptr, getsign(st0_ptr) ^ getsign(st1_ptr));
