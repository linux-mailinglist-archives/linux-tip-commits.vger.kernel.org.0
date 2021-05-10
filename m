Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C22C378880
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 May 2021 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhEJLVl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 10 May 2021 07:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbhEJLHB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 10 May 2021 07:07:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E03C06134E;
        Mon, 10 May 2021 03:59:42 -0700 (PDT)
Date:   Mon, 10 May 2021 10:59:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620644380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWFx+N1pchqz8HPhDmF/v03BikcazZzImZU8iNVKbPw=;
        b=XixftHA2Z7bv9uZW10LrcK6EroJXU/lgH8oX7jqs8sy9UaSUl6p7Yztuj3pRA316c8i17r
        LUfApUzJSinDJnIWHgSOyIP4SKUK6dAkYiDdig23I1QjMlIDzk6CpfXm6+gQOP8B8UFIr2
        GjUXsoAf2XkT124e9c2TsG6Fy9hpq/sXUgyOAw0a4yy0j6Z1oFPl6FeWcEqIEtrY8GHxwS
        QwM2KYK5Nnux35GXB9GUnFiwXRaB8tMMjU3Q52J+OYjpX7ZdUh1fWhrCt5I/6hDGIsDUCy
        kgkX3r8NOkXXG1kf7+K+Q/csJPS2UmqYDWdAlFk/NZPYPIkUqx5wmjxVK37O0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620644380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWFx+N1pchqz8HPhDmF/v03BikcazZzImZU8iNVKbPw=;
        b=rfNttOb2qwE9s//IQgDnPExCLnvpka9UjxC5xkcGQKSCUy1p01YbC3kbnjjILf4DIeWcKJ
        SFdDBIhmOCSgxlDA==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Add _ASM_BYTES() macro for a .byte ... opcode
 sequence
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510090940.924953-3-hpa@zytor.com>
References: <20210510090940.924953-3-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162064437935.29796.14044755304538421438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     d88be187a6e6f3a97dfa7ddc500bb9ca191b3772
Gitweb:        https://git.kernel.org/tip/d88be187a6e6f3a97dfa7ddc500bb9ca191b3772
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 02:09:39 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 May 2021 12:33:28 +02:00

x86/asm: Add _ASM_BYTES() macro for a .byte ... opcode sequence

Make it easy to create a sequence of bytes that can be used in either
assembly proper on in a C asm() statement.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510090940.924953-3-hpa@zytor.com
---
 arch/x86/include/asm/asm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 93aad0b..507a37a 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -13,6 +13,8 @@
 # define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
 #endif
 
+#define _ASM_BYTES(x, ...)	__ASM_FORM(.byte x,##__VA_ARGS__ ;)
+
 #ifndef __x86_64__
 /* 32 bit */
 # define __ASM_SEL(a,b)		__ASM_FORM(a)
