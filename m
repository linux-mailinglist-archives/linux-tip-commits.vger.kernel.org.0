Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5451409D42
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Sep 2021 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbhIMTkl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 13 Sep 2021 15:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbhIMTkg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 13 Sep 2021 15:40:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F6C061574;
        Mon, 13 Sep 2021 12:39:18 -0700 (PDT)
Date:   Mon, 13 Sep 2021 19:39:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631561956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIFVTP63fC5PxxG7VYtTXHXiiYi2sUePbqqg1sjmM88=;
        b=SORIhClBNZOWbyQZC9CjZHexb4Q+fCha6DnbLhbojCqCJ+4uMqGudAn24ChuVtUptLVdRt
        Qdzv5WxYy/pl/sY00zuGUWH1KKzVYYD4hjkXxPoGLwAsB9Yl+cXeqYh6UDCC+yHPnQoqJx
        toHeueiwAO/yE47HKal+/F6v/xbDFUjCzZpC3NFyFsQanYLrF8Y6Ceob8gRqFZWCL3K6v2
        N+syQmCfmQ5AU8r0H0HUNvX5jCHJXso4ZquRpkV9y5CUQ/RZGhz4K0HgGd8Wea6tSzRdgH
        XQTRyYgm4oYD+d0V0opSGBVfK/wnyXWhDWNS0+NRcTTJhoLUJg89NcMDaQTeXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631561956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIFVTP63fC5PxxG7VYtTXHXiiYi2sUePbqqg1sjmM88=;
        b=ZiEosdul10idSD5KZUgt2uBZkOmxK/BJXTIjYpku2p7eUSyb0vE1dSljtFI7CzG3r1DV+P
        s+5NO22AZSF3ViAA==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210910195910.2542662-3-hpa@zytor.com>
References: <20210910195910.2542662-3-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <163156195608.25758.12610850941164059145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f87bc8dc7a7c438c70f97b4e51c76a183313272e
Gitweb:        https://git.kernel.org/tip/f87bc8dc7a7c438c70f97b4e51c76a183313272e
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Fri, 10 Sep 2021 12:59:09 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 19:38:40 +02:00

x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix

Add a macro _ASM_RIP() to add a (%rip) suffix on 64 bits only. This is
useful for immediate memory references where one doesn't want gcc
to possibly use a register indirection as it may in the case of an "m"
constraint.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210910195910.2542662-3-hpa@zytor.com
---
 arch/x86/include/asm/asm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 3ad3da9..c5a19cc 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -6,11 +6,13 @@
 # define __ASM_FORM(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
+# define __ASM_REGPFX			%
 #else
 #include <linux/stringify.h>
 # define __ASM_FORM(x, ...)		" " __stringify(x,##__VA_ARGS__) " "
 # define __ASM_FORM_RAW(x, ...)		    __stringify(x,##__VA_ARGS__)
 # define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
+# define __ASM_REGPFX			%%
 #endif
 
 #define _ASM_BYTES(x, ...)	__ASM_FORM(.byte x,##__VA_ARGS__ ;)
@@ -49,6 +51,9 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+/* Adds a (%rip) suffix on 64 bits only; for immediate memory references */
+#define _ASM_RIP(x)	__ASM_SEL_RAW(x, x (__ASM_REGPFX rip))
+
 #ifndef __x86_64__
 /* 32 bit */
 
