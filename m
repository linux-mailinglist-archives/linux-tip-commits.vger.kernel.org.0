Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052EF264E19
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 21:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgIJTAZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 15:00:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgIJSzE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:04 -0400
Date:   Thu, 10 Sep 2020 18:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O1U9gwlmdTl0TOace+0dFjWfuN/OBnld9Ordkmuttgs=;
        b=1YYqsvlrcVIIy19hHYEMC2SGkMI0rXq2bX/Jt35yqaMM+Km5PfL+Sfkn03wHeLS4ZaJJZw
        g4AbUfeMZ3QehkzuntDW3ncfx4GQG+eVywSUzLs/iLSOxKur2zUoXnBOKGDV3qHtw6ynNu
        7NNbGtPBfZEQYdFXfg5vbAvKqmgN4obwQTRjTlzDBfXWm6+u0ua+Gj+rccyzgiQ78TxKwR
        x7Jia7ogdjEnJA77n+WbxRjA6Y9dC03/3yHZyg2siXjqjhbKNuBzcZ/eU8uiM1LP/RKON4
        yeLc6mwsRi7FM3jjJ1QOuaqAsvhfHJbK0ZOy7+1oaMkyzLH2G6T7hQv+aJs5Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O1U9gwlmdTl0TOace+0dFjWfuN/OBnld9Ordkmuttgs=;
        b=/ydKEwGH8Hz1chwX1gGls1VnnLY2uBasYQQTZ0iHxDMcxpfvUAPiA3mPVoVOPL3B1g+hlC
        tP6K3DBT1C/y3UAA==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Only include valid definitions depending
 on source file type
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407532.20229.15338761572639027794.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5567c6c39f3404e4492c18c0c1abff5556684f6e
Gitweb:        https://git.kernel.org/tip/5567c6c39f3404e4492c18c0c1abff5556684f6e
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:26 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Only include valid definitions depending on source file type

Header include/linux/objtool.h contains both C and assembly definition that
are visible regardless of the file including them.

Place definition under conditional __ASSEMBLY__.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/objtool.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 358175c..15e9997 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -3,6 +3,8 @@
 #define _LINUX_OBJTOOL_H
 
 #ifdef CONFIG_STACK_VALIDATION
+
+#ifndef __ASSEMBLY__
 /*
  * This macro marks the given function's stack frame as "non-standard", which
  * tells objtool to ignore the function when doing stack metadata validation.
@@ -15,6 +17,8 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+#else /* __ASSEMBLY__ */
+
 /*
  * This macro indicates that the following intra-function call is valid.
  * Any non-annotated intra-function call will cause objtool to issue a warning.
@@ -25,6 +29,8 @@
 	.long 999b;						\
 	.popsection;
 
+#endif /* __ASSEMBLY__ */
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
