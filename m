Return-Path: <linux-tip-commits+bounces-5332-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7EAAD976
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FD83B3D4A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708AB224226;
	Wed,  7 May 2025 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqcrE4WO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qfxRxkEe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BE221FB2;
	Wed,  7 May 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604676; cv=none; b=RADZXxuxXi+40inEEn1j/TYLONSM5fqENJ2pcEwyi5yDNOOTKp+rCImi5MWZB7pKkNu/XxL/BjiysQJq151S4yivb5r/WdRtl4zmyP0lWUwsvpzAKMSryU0u0lVst1Zdegd03lq8m1W3Lsa4lwviON9EkEtxr79UQRR75ea6fTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604676; c=relaxed/simple;
	bh=S6TUbfdjVFWVKcVPbK7vARyJKb7pE+BLb1/YKnx+BE0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r8ddwEfRpG1hsflXSC/3glFY1US8WhYirxCuHSNhKdPfALiSGpKtdy3P7g17EJ3wCFLLXpW0vnm8H43VHUwRDhD/r5hPA91Jglrji+/FKwqmv1AN2UKgeIVFXVO8H/MnW2UNsg6Dwt2asBVc8+ZrCJyVDa3+d+hM3kp7qyLQPo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bqcrE4WO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qfxRxkEe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av3ImIp4OIZCrWFPW3GyAPy3j+U0Cxdn2V2fCoAh/EI=;
	b=bqcrE4WOIRcQAvi/ZiFMiGH/9HZbfImdEqd/hDIVQ1SGZaD/qkJXFykJAH866wZOh0WyIe
	nO8Aji9hJyAu9/NqKaLCJytGvHtq3Xsde48xtcAEcUJWoU8Sh09gGmnuMDKSN8qyOTYgPF
	b2xqpU88Oh/2nXXhgxGLExqyhoJyG4URxATa3gbwrklWbzsIq56MlgLvtaOr3EoyYzxCMv
	ACxhy4O0cDnLmzfapKygg6FNF7b3iRBEzZHnf/LPpbx6dI0EmAcs18eIxj+Qb2LAYrtJ8m
	nhL6ixb5H2a9KILs1tHd+vrIUv7Fb7HVXJ5hct9/6ALLl0/WNI3xVKgNAvsFQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av3ImIp4OIZCrWFPW3GyAPy3j+U0Cxdn2V2fCoAh/EI=;
	b=qfxRxkEeZ1qIhCim23e78enZ6lfCAvo1e8rhSqj+nG6k1SNUpDQ6WbX8AEa6psoi9EEVUx
	VN9zhBJAMyL4AFDg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] irqdomain: Use irq_domain_instantiate()'s return
 value as initializers
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-51-jirislaby@kernel.org>
References: <20250319092951.37667-51-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660467129.406.13202195174890278442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     087a483741e262967b2ab71a8d2d314512d3f178
Gitweb:        https://git.kernel.org/tip/087a483741e262967b2ab71a8d2d314512d3f178
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:25 +02:00

irqdomain: Use irq_domain_instantiate()'s return value as initializers

This makes the code more compact.

Note that irq_domain_create_hierarchy()'s handling of size is now part of
info's initializer (using the ternary operator). That makes more sense
while reading it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-51-jirislaby@kernel.org

---
 include/linux/irqdomain.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index c8e55cd..1e38584 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -403,9 +403,8 @@ static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *f
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
@@ -424,9 +423,8 @@ static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
@@ -440,9 +438,8 @@ static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fw
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
@@ -554,18 +551,14 @@ static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *
 	struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.size		= size,
-		.hwirq_max	= size,
+		.hwirq_max	= size ? : ~0U,
 		.ops		= ops,
 		.host_data	= host_data,
 		.domain_flags	= flags,
 		.parent		= parent,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	if (!info.size)
-		info.hwirq_max = ~0U;
-
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 

