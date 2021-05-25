Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3301038FDCF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhEYJar (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 05:30:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhEYJaq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 05:30:46 -0400
Date:   Tue, 25 May 2021 09:29:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621934956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PS5hdhUWb8OQ6PlVKjVY9PEZytcB7g6KJPBJLpJVZy0=;
        b=FqmhWOER+9g6tLAVolYIMNYFWATsYJWCfE6FDzcRyzc9m+PDaK/U8Leaiv4eQ6VgFEM34o
        OLkI4Rhw/UYoqtZqiikqIp9kpWYUZYkRS+YFN90v+qsSALI9Gfsyg6HqsBqCBgJLVKSIqx
        S6BAWaqlNMrLk27+YYJ0WmOaks8qQ0y9F6aybv6nda4O41Yn/76MNwUzxqf19X7cG1Xd2h
        ThSdExazknucbJCC9gkrV9mXsn4P9j0wJQ4irmTfcArkodjKkDkM0qOSstpAUt0eZSaRZl
        3EduCYd+595SibOyWSmYsu02msICyHLqh+zdnc3MJnqkU3RKhsdRFzjDYkfC1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621934956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PS5hdhUWb8OQ6PlVKjVY9PEZytcB7g6KJPBJLpJVZy0=;
        b=YskncC7yu/idy7yrapYNkoN/coN7yUFwtKThPHyyNpjLyeDPafqsPUyNGvRReNLErt1JCT
        huIiJYdPJ1n0bNAQ==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86: Add native_[ig]dt_invalidate()
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210519212154.511983-6-hpa@zytor.com>
References: <20210519212154.511983-6-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162193495585.29796.365548001305216256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     283fa3b6483a84aeb62f1b97c2ec7c02eb2f5882
Gitweb:        https://git.kernel.org/tip/283fa3b6483a84aeb62f1b97c2ec7c02eb2f5882
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 19 May 2021 14:21:51 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 May 2021 12:36:45 +02:00

x86: Add native_[ig]dt_invalidate()

In some places, the native forms of descriptor table invalidation is
required. Rather than open-coding them, add explicitly native functions to
invalidate the GDT and IDT.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210519212154.511983-6-hpa@zytor.com

---
 arch/x86/include/asm/desc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index b8429ae..400c178 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -224,6 +224,26 @@ static inline void store_idt(struct desc_ptr *dtr)
 	asm volatile("sidt %0":"=m" (*dtr));
 }
 
+static inline void native_gdt_invalidate(void)
+{
+	const struct desc_ptr invalid_gdt = {
+		.address = 0,
+		.size = 0
+	};
+
+	native_load_gdt(&invalid_gdt);
+}
+
+static inline void native_idt_invalidate(void)
+{
+	const struct desc_ptr invalid_idt = {
+		.address = 0,
+		.size = 0
+	};
+
+	native_load_idt(&invalid_idt);
+}
+
 /*
  * The LTR instruction marks the TSS GDT entry as busy. On 64-bit, the GDT is
  * a read-only remapping. To prevent a page fault, the GDT is switched to the
