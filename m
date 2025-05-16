Return-Path: <linux-tip-commits+bounces-5571-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37530AB999C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 12:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C0E16DCA4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E8232395;
	Fri, 16 May 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CYRfJpOn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lv0CiGYd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664A220F2F;
	Fri, 16 May 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389741; cv=none; b=IVNBGxZ7lyK7n7Ya7jDIM+Ws0CyAUkMfyzaNKUYr1Ci6tSAb4TcKXjLZGBy5ExbaTUvjOlGTV221SdMe3tcUV85gKi1XUMahJ4oo5U6+UWvDcwdOc+kQl/owzNKxysVghxGZcnLAQisJ4RAA6ujhKpfq44Q8BEQnKpnxyDNfxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389741; c=relaxed/simple;
	bh=eE2OtKFULVZMggnxR8+ZJlyAJyMCu/EHspEpeqRx54U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a8lGOfeZO4INMBiZ+VodWOqGuXbF09oIw6mjg6HCqqDxFL+/CKmnl1te8yrWZDxDa7EWHaxvmOitB2zpHpVcvoibewUx6aauamSknpfS8KP+a2+M8sPmbs9xB3RLJumY4GnEqIwqMbgzBBZJi5Fe1eUowDaqGVPFft3t9Q0Sb6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CYRfJpOn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lv0CiGYd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 10:02:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747389737;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXhYZh9rOAHKc/VSK/2xbjXnpc7MpveUyEBAMOc7oho=;
	b=CYRfJpOnz3KmHNpjVDCTyh1YMAezKdLp2n496YXCkPz3G+IgSNC4YjNIL9ayQ4eLSn8r5t
	We76m+7pBcjH99SbDFhd+S4JbhCJTaZaaRD7ab0koxXG7YjiPgoTTy8W1DCACJbf0IVPNH
	wiBV4ojFwOtNtL5sLS+ZK0SFQUD3nWE4mYdsYLlh4dcVaD+KVic/N0oD3SqM9ZB9FmkcxU
	cyGZlX9lKQGmfLXrOXzsyIf08LZGpGzejT4LWvQdG0UdgrhvF0Ai6hhockSDIzwyo/wdG6
	hl/loOaoADJm1rASQQcmg/L0A8n+93pxKlsGgLI0FE1ANz9M0sSgnigh1scLsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747389737;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXhYZh9rOAHKc/VSK/2xbjXnpc7MpveUyEBAMOc7oho=;
	b=Lv0CiGYdHWxj+BQvVO+7XOcRP+2uLMIpL1X4lB0DFsBsmT23q+CQgW7gWfRnmvfcwcEeSg
	vNIA4cy019+xonAQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Engage the .msi_teardown() callback on
 domain removal
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513163144.2215824-5-maz@kernel.org>
References: <20250513163144.2215824-5-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738973633.406.11378243360513505199.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     03c298760ed97c5981402d64c4eed9bc4f2f0a4e
Gitweb:        https://git.kernel.org/tip/03c298760ed97c5981402d64c4eed9bc4f2f0a4e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 17:31:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 May 2025 12:36:42 +02:00

genirq/msi: Engage the .msi_teardown() callback on domain removal

Kindly inform the MSI driver that the domain is torn down, providing the
allocation context previously populated on domain creation.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513163144.2215824-5-maz@kernel.org

---
 kernel/irq/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 1098f26..b5559fa 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1096,6 +1096,9 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 
 	dev->msi.data->__domains[domid].domain = NULL;
 	info = domain->host_data;
+
+	info->ops->msi_teardown(domain, info->alloc_data);
+
 	if (irq_domain_is_msi_device(domain))
 		fwnode = domain->fwnode;
 	irq_domain_remove(domain);

