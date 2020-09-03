Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0524625CB94
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Sep 2020 22:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgICU57 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Sep 2020 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgICU56 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Sep 2020 16:57:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9664C061244;
        Thu,  3 Sep 2020 13:57:57 -0700 (PDT)
Date:   Thu, 03 Sep 2020 20:57:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599166674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ20J1YSqOfNWFeT2d2mdgWk7Y+euLW9UaUt0BBj1Ps=;
        b=hPf9J6SSh/ic0F+Nv+pNMkyRTgsm2/xC9DmJ4N99inQArqfIWn9FGIkbOvfSNyI1RAM5DR
        YO7yrLz6ncrHEU0k5S4P4SHvjcEgjaeId+/r+uoi9ThxmmUp0y44dCUM3Ejdjs4Tl/49hO
        +muywDPpbGhZTbRSir/Z08BQH3KKYvx2DXT175r9zz3vp24rpR2qvy1X41p8NtfBxEE2c6
        roI7UFtS8zOW/2ESBlbrUNvY+oe/nWO0eST7egUpc4tFgHgECU7/G7GPxdVRjehdZMp56I
        ovgvMK5/4xFzpcJW22RG4QROftqViiZFA/KfICZU9rfb1ncuwlsuc9+pfG2rcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599166674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ20J1YSqOfNWFeT2d2mdgWk7Y+euLW9UaUt0BBj1Ps=;
        b=39at3G12Rg5PBDmWl306lDRgzDBXpFiKaviJxvhuQZzWOUG8g9EyeRE8inoYqpmxttP8+1
        +Dhfd9sr5WBx95Ag==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/uaccess: Use XORL %0,%0 in __get_user_asm()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827180904.96399-1-ubizjak@gmail.com>
References: <20200827180904.96399-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <159916667349.20229.3414153735244091368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     767ec7289e83721fee205a13b459f12fb2cf922f
Gitweb:        https://git.kernel.org/tip/767ec7289e83721fee205a13b459f12fb2cf922f
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 27 Aug 2020 20:09:04 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Sep 2020 22:49:03 +02:00

x86/uaccess: Use XORL %0,%0 in __get_user_asm()

XORL %0,%0 is equivalent to XORQ %0,%0 as both will zero the entire
register. Use XORL %0,%0 for all operand sizes to avoid REX prefix byte
when legacy registers are used and to avoid size prefix byte when 16bit
registers are used.

Zeroing the full register is OK in this use case.

As a result, the size of the .fixup section decreases by 20 bytes.

 [ bp: Massage commit message. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20200827180904.96399-1-ubizjak@gmail.com
---
 arch/x86/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ecefaff..2bffba2 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -343,7 +343,7 @@ do {									\
 		     "2:\n"						\
 		     ".section .fixup,\"ax\"\n"				\
 		     "3:	mov %[efault],%[errout]\n"		\
-		     "	xor"itype" %[output],%[output]\n"		\
+		     "	xorl %k[output],%k[output]\n"			\
 		     "	jmp 2b\n"					\
 		     ".previous\n"					\
 		     _ASM_EXTABLE_UA(1b, 3b)				\
