Return-Path: <linux-tip-commits+bounces-5289-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE3AAC5E2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C986175776
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66326286413;
	Tue,  6 May 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhdJAwIx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oiwl5TFi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484028541F;
	Tue,  6 May 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537633; cv=none; b=b8Bih6tb+aGPmkhsvgbf0JWoLb/b7URVEqgUCY77yV9Q4Y0hzSH9WOT+FYN46Kc6PvBJIYpjCvq7EN5BGMFFQKK7wXTa6p+GaPvtN1J7g3LXAe/WTZepRiagn9TtPKtVlovQeM1rPGxYOogFrUXCOR6RPDuQ606oKAbdhabTiSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537633; c=relaxed/simple;
	bh=x9y36IpS36DbYayptCqILQl/Pc8J4l508vxLPDDlur4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OTZaTNQA20umRWn3Bkgpf4D+QAN7ZPtj5O7zF2/K/hRDxhrZKkA+JyGtgwZ0ZDCX4g+pHK4XhTPbD71DiHMy8+i42UvbW9vT7AuS+bbN9VEjNKdM9EIfm+gq0P4Qupil9a9Cg3faSKXSevvf5c2Z5f+ScCv614WNxWHc5JWUY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhdJAwIx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oiwl5TFi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PW94Wl2WyaxLi5j/E6x6VYIBfJwcvoROcz5azKnFC58=;
	b=lhdJAwIxWC3IHs/bNK6VnuioLyqLLmD3VeRlZmGJRBvE7O/5heihFmzvFmz93x3VevBIs7
	RJtaGXHx7Lqtk5gpmiCG3pJNm+LhO+0cdpVAUqBftIQ27C09YW9C9WvWjeZRuucZBVrVe7
	/wcWYykK3iLm+Wd1h4/8cRDEZblpoD/KWaoYVJFk+O8MQpMWYMRfr52eJ3JzlGCFV4BhVj
	qCF1e7gsN1A8Pa2poBj+XzlvgaB5DsdqBZcnhM1tl3Hv6u5kzWmR7lJcEWnZjCnr7PSkdQ
	3jFvBjv7iO0O5ZKodde5rEYq3qPxNcSQq7K/tYKuCzWrc09c3Ve09MbhhTOV+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PW94Wl2WyaxLi5j/E6x6VYIBfJwcvoROcz5azKnFC58=;
	b=Oiwl5TFiJl7S/XJu7+bizaS1wsHYK80cpd3WDUf/1rei53VUqpyaIbX1ylxb15b4URMRaz
	Nhx6d5IwmPWiuWDQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] nios2: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-29-jirislaby@kernel.org>
References: <20250319092951.37667-29-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653762885.406.11382999713997829533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     dd16951ab4ab3ac265ca2d18d2aa0694dad453ec
Gitweb:        https://git.kernel.org/tip/dd16951ab4ab3ac265ca2d18d2aa0694dad453ec
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:06 +02:00

nios2: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-29-jirislaby@kernel.org

---
 arch/nios2/kernel/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index 8fa2806..73568d8 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -69,7 +69,8 @@ void __init init_IRQ(void)
 
 	BUG_ON(!node);
 
-	domain = irq_domain_add_linear(node, NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(node),
+					  NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
 	BUG_ON(!domain);
 
 	irq_set_default_domain(domain);

