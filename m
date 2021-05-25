Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C739046A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhEYPCZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 11:02:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhEYPCX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 11:02:23 -0400
Date:   Tue, 25 May 2021 15:00:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621954852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RS4XeeCJDuFxFV0LqWLRFzAnG8tvvnHNmjCgAeBU3wU=;
        b=Uf9sjyYWsI9jwCxPoFrGId4KBjeXI/ShbU7yCQCLlh8nvdmW9AgfW/0k/f2aAWTL6k6TKJ
        Gf997F1zz02G66wHN2OzVT8yZNf1s695R7vC6DxxZXlg/zwAhG/BAc0ci4/InaZr4bjr9f
        8FjuvUXDeoONXnaW8g4ppBaPKRl/1+c7hI0lwszMj2ukvYT8UTE/UMWR0V85iIu92WM51m
        X6FibNeM9fmBCeSeLcPZh5ktdh6jm6JAY4v1/Hp3hpU1E/q6Rh07bBZPXlNtWmjOsV2ojj
        qLjhuJPqmNi0xzwzL9sxZga8FyyLRH2y/eTg3gyGrqL/ZPBDRhqXZrxg+otd4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621954852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RS4XeeCJDuFxFV0LqWLRFzAnG8tvvnHNmjCgAeBU3wU=;
        b=Kna7FELxuv3sJpnaScwPXtZ7KmB38K9vZMkDG5v8f2YoS9HSvg5f/AB+k1Rtm4t0YcTdNX
        BOT2+0RI/YFJ+WAw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/uml/syscalls: Remove array index from syscall
 initializers
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524181707.132844-2-brgerst@gmail.com>
References: <20210524181707.132844-2-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <162195485173.29796.5553283004529180620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     d48ca5b98fa5d21444e04bb17373d339200b679a
Gitweb:        https://git.kernel.org/tip/d48ca5b98fa5d21444e04bb17373d339200b679a
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 24 May 2021 14:17:05 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 May 2021 16:59:23 +02:00

x86/uml/syscalls: Remove array index from syscall initializers

The recent syscall table generator rework removed the index from the
initializers for native x86 syscall tables, but missed the UML syscall
tables.

Fixes: 44fe4895f47c ("Stop filling syscall arrays with *_sys_ni_syscall")
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/r/20210524181707.132844-2-brgerst@gmail.com

---
 arch/x86/um/sys_call_table_32.c | 2 +-
 arch/x86/um/sys_call_table_64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index f832310..0575dec 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -31,7 +31,7 @@
 #include <asm/syscalls_32.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, sym) [ nr ] = sym,
+#define __SYSCALL(nr, sym) sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 5ed665d..95725b5 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -39,7 +39,7 @@
 #include <asm/syscalls_64.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, sym) [ nr ] = sym,
+#define __SYSCALL(nr, sym) sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
