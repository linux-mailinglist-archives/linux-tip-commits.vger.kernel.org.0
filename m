Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6B35AC72
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Apr 2021 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhDJJ2f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 10 Apr 2021 05:28:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55662 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJJ2f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 10 Apr 2021 05:28:35 -0400
Date:   Sat, 10 Apr 2021 09:28:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618046900;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kGIPj4SQZcv0/wBkkIdwyWDpziRZinACvXDJl8d9nmY=;
        b=tnV7mpHUS/w7Ax+DyLVcmQ4ILbfAEQ7xbqPoaKj0LLll7kVi+/Jn8i/eQ5lRC70pSUaa55
        2VGToxGdVOGpwJFEBQp7ICwY9rq2Jt2AkCKR5HpsH4NAk+vX+anvKNuSyqSZcFYsLLmyuF
        SHKU2rdaOEF6O3XyBrUcjLD62zu9zyrHvFbl16T8wmZvGlLmC06L/buMnnXczrPwpRoTAL
        HeVqoSGym/NQvZVCr2Ix1VlM8Boy5zVfo0dd0EGSDN5o4tfJ+YHgafgj34Jj5/V3lK4Jb0
        fMcx0/vefaMBjVLgGsyZ9hINFJgRtLVVPTdm1j/A0kR7GnIbq1BegBMWIgL1HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618046900;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kGIPj4SQZcv0/wBkkIdwyWDpziRZinACvXDJl8d9nmY=;
        b=kRcdVkxsNmvxb7LNrsMfpWqD9Hleyb82Jhwd0V/8lS8ilBQt1o0a3DVzjGthPUL3deNCMG
        1FHBd2e/q2OBIKBA==
From:   "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Comment Skylake server stepping too
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210409121027.16437-1-andrew.cooper3@citrix.com>
References: <20210409121027.16437-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Message-ID: <161804689861.29796.13981417353552777541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     99cb64de36d5c9397a664808b92943e35bdce25e
Gitweb:        https://git.kernel.org/tip/99cb64de36d5c9397a664808b92943e35bdce25e
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Fri, 09 Apr 2021 13:10:27 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 10 Apr 2021 11:14:33 +02:00

x86/cpu: Comment Skylake server stepping too

Further to

  53375a5a218e ("x86/cpu: Resort and comment Intel models"),

CascadeLake and CooperLake are steppings of Skylake, and make up the 1st
to 3rd generation "Xeon Scalable Processor" line.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210409121027.16437-1-andrew.cooper3@citrix.com
---
 arch/x86/include/asm/intel-family.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b15262f..955b06d 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -33,7 +33,7 @@
  *		_EX	- 4+ socket server parts
  *
  * The #define line may optionally include a comment including platform or core
- * names. An exception is made for kabylake where steppings seem to have gotten
+ * names. An exception is made for skylake/kabylake where steppings seem to have gotten
  * their own names :-(
  */
 
@@ -74,6 +74,8 @@
 #define INTEL_FAM6_SKYLAKE_L		0x4E	/* Sky Lake             */
 #define INTEL_FAM6_SKYLAKE		0x5E	/* Sky Lake             */
 #define INTEL_FAM6_SKYLAKE_X		0x55	/* Sky Lake             */
+/*                 CASCADELAKE_X	0x55	   Sky Lake -- s: 7     */
+/*                 COOPERLAKE_X		0x55	   Sky Lake -- s: 11    */
 
 #define INTEL_FAM6_KABYLAKE_L		0x8E	/* Sky Lake             */
 /*                 AMBERLAKE_L		0x8E	   Sky Lake -- s: 9     */
