Return-Path: <linux-tip-commits+bounces-5591-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C55ABA3EC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAFEA25F44
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775E280A3C;
	Fri, 16 May 2025 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovMe/dW+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mw9Xswey"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459E28002F;
	Fri, 16 May 2025 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424246; cv=none; b=khBm8Q0bntRsOlKzQbu2zD5kl3axNurGAeZymGaDti6i8zIS1d4GezUYLAggb4I3vCwMGGvmCw/yCf2VDmOWbzlyAVI4bJaUeKnDnadr4Dsg++5WwsY2vyFmxD+H2LObS5Xk8ryZ8wVSl1RQ3AHMeOmgVKKao2Jggg99CANdJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424246; c=relaxed/simple;
	bh=HjBePI3pcid90HUDlvURYIvJcsz2RKYmCDTRIc8HutI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DyCQQahHn35AoEHFL2dEcK13pimchuUf/fmHZJyhDTQ7QMZNJAJYwveXxgPz+GZMb2byd6XctqhHKvfN+G6iXU29uA4Cxc17mo0qGbG92v3PN/ZfU8DaR6W3Gmj3vzgVkL5l8gRXjCqGUB8jpoKt8AvQcqr9eSOIFQ4QpzYEaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ovMe/dW+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mw9Xswey; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9/wlWYPj4NBEu2ulYTSswRpb1jfYtouoAVjJMGdaRo=;
	b=ovMe/dW+eXHH2lVCvh7j3dvKYeEiXuEaKKI96wGADOGhhmmcfDTi5T6Er7MRX/ORIuZeMO
	x30SWuiracjtXr1x0MCPd4SC3qXuBzx2xow30C4a1BzyijNhj3Ng3vX05uG3n5Gjp3l60p
	njFZr23IxgLruIErIBK+pIGW3pao6DuS5Iy1Gd08EEPf4sBVUHmvKN0p2aThsBkkaFTMlT
	OerDHDgKwMmpzt7FDGjoqkX2WnRW1cOFmRsopA78Ja9YjF9rmFfDgm6NAHNKnX753MBKjw
	ZnWJNPN0k+I9bBTmptGKyC1ayEbXLVSi1B0g7c6E4wtKRb1pd0ZjPYko7ia5Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9/wlWYPj4NBEu2ulYTSswRpb1jfYtouoAVjJMGdaRo=;
	b=Mw9Xsweyq/uduUTe1gtPgleKzW7o6+Xxa05KJyqLsJd45hbCmpx92GI/Vdh5E4nMnNFWmP
	ZEOCTdtjxqTV8nBQ==
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
Message-ID: <174742424229.406.11707337488594164446.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     18e743e911020eb74cc4eaf549c18ed12a5acb9a
Gitweb:        https://git.kernel.org/tip/18e743e911020eb74cc4eaf549c18ed12a5acb9a
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:12 +02:00

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
 

