Return-Path: <linux-tip-commits+bounces-7760-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799ECCB3C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 10:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C8ED302771C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877E20296E;
	Thu, 18 Dec 2025 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AElE1Zls";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eDWdCkso"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50526059D;
	Thu, 18 Dec 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051144; cv=none; b=OkeaviL18OmuIK7UnkcpTNKwnzVUOwFaHMs/CWCDfdnxZwxqHKq7rRSwOJijhPj2BiHSLMPsM/S4I1RTNFw09xEtNr3A0x/mgXCnFskSvmTMqf1Sn9+R+mnhGcfKy9w8bG9J60p0GxcK56MBS4ik0tCD8OJdwoViNTZCBJsogco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051144; c=relaxed/simple;
	bh=/FuVnMAiwhfY5x0P3E0ZIzGBd58hzF5lfNAue7SQdWI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gl2GBkpnSa8Y0FCNV9lR4xITCnTp0YZAVA1NTGM/M0O6nnd+PhnQfzdT/aKe6gKzmq0LIUGDdR6FxCeftEyZhXgP2JcMgKZOiVULuardQJBrAuRaSBYBUBuQO1Kcq47j/aNmWIca4Ay31c8/8EDHUqv7qAA6lA2nXVP6w9e+VKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AElE1Zls; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eDWdCkso; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Dec 2025 09:45:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766051141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWxKyRYpZ8s5v8OHPGFQYGv95uFY9WcweLkzqub+UHo=;
	b=AElE1Zls1p2WFGRSBb3lI1+e1nltK/dIYFpH7D8vm2ebW9JkmelGn07b6G1NH7PWisKrOY
	+HC+75zgmGywa8D/hWuzz44JgUtQvfMdxhrJf2ysOjhiO7HVebVcufHGioTFafRVr3JJ0A
	Ev6caz1xJYogUc7EW6eXERQ+UpBza4TcpnMmv4xyUopuHDYHcL1S5hF9FNYMqFXeDV3AZ1
	kBv2cQ+HjzurAWK+sRh5tFxWh5wWFxNSd2VI26n7p9uLy1il9qyuTjd7nFeSCD46Ov2Kjf
	Kg0tReD9x3eAg6CPk4btgwqVib9QFo+xaUAdHDiOdmO2OT5aLVWuMz9qbt8Wuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766051141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWxKyRYpZ8s5v8OHPGFQYGv95uFY9WcweLkzqub+UHo=;
	b=eDWdCksod9ChmONElv22Qkny3CqmVBqkT3cGq0bQ5nm/eW1jC8PfOecKGsx8CNGECfCbZc
	JmCc14mCs6qQboDA==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] entry: Always inline
 local_irq_{enable,disable}_exit_to_user()
Cc: Eric Dumazet <edumazet@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251204153127.1321824-1-edumazet@google.com>
References: <20251204153127.1321824-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176605113985.510.268525550797363050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     4a824c3128998158a093eaadd776a79abe3a601a
Gitweb:        https://git.kernel.org/tip/4a824c3128998158a093eaadd776a79abe3=
a601a
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Thu, 04 Dec 2025 15:31:27=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 18 Dec 2025 10:43:52 +01:00

entry: Always inline local_irq_{enable,disable}_exit_to_user()

clang needs __always_inline instead of inline, even for tiny helpers.

This saves some cycles in system call fast path, and saves 195 bytes
on x86_64 build:

$ size vmlinux.before vmlinux.after
   text	   data	    bss	    dec	    hex	filename
34652814	22291961	5875180	62819955	3be8e73	vmlinux.before
34652619	22291961	5875180	62819760	3be8db0	vmlinux.after

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251204153127.1321824-1-edumazet@google.com
---
 include/linux/irq-entry-common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index 6ab913e..d26d1b1 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -110,7 +110,7 @@ static __always_inline void enter_from_user_mode(struct p=
t_regs *regs)
 static inline void local_irq_enable_exit_to_user(unsigned long ti_work);
=20
 #ifndef local_irq_enable_exit_to_user
-static inline void local_irq_enable_exit_to_user(unsigned long ti_work)
+static __always_inline void local_irq_enable_exit_to_user(unsigned long ti_w=
ork)
 {
 	local_irq_enable();
 }
@@ -125,7 +125,7 @@ static inline void local_irq_enable_exit_to_user(unsigned=
 long ti_work)
 static inline void local_irq_disable_exit_to_user(void);
=20
 #ifndef local_irq_disable_exit_to_user
-static inline void local_irq_disable_exit_to_user(void)
+static __always_inline void local_irq_disable_exit_to_user(void)
 {
 	local_irq_disable();
 }

