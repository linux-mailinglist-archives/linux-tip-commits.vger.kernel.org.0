Return-Path: <linux-tip-commits+bounces-5275-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0EDAAC5C5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D293A944C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9722820AE;
	Tue,  6 May 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gXwTLB8Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wOYE8K5b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F79428136B;
	Tue,  6 May 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537622; cv=none; b=Ubnhm/BIBGP45JNbpwJj3urii3+bwmPYdB+iWAlwODUDiftmTOO9X1Rd2hGh7hcWXtIYk2UIQGszOMktXJLg/zdBNeeagjnjf6o7QHtpx558jKJJBC9BtvteotfMWVTGd249emqkJiRMFstCd1bMnAQa18Ll9ahpyNKJHgTc+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537622; c=relaxed/simple;
	bh=qWybfri0M0d+gap9xpkJjO0lo46QfqdLRFy9mykWbYY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tbW6NerPj04W4CO/Or7exm4vHF0mBBWIcMTH1LmQKtEll/nV973YdImfodiy1+1o+18MRKQUZyq3BWvNh8yIifMVVMrWiMDhRaykO9Rx8UHTQnXAZF1PaojZ9auxBzf1IduGi/SVKHqSjoF9S+UKObewJA3/PXVPTZJzFkw1u4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gXwTLB8Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wOYE8K5b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I33bwJEFFWyHGsdtr91jRQ3+9FS+jSE85doTBUJ8znc=;
	b=gXwTLB8YgcdkbqP5xC80FfeQHFkKr0zhywScDtXoTOYToFwihbvYCDQNTbdfwiUWcxZR8o
	gwXARdnLhM8c2DE4sZeB2pmfhvmyXiBMlM+nWEhg4LsE8pbjSfZvNZJ/fi00rf/PfR0T24
	8XrqQbPdtHVogO+pdKa6lftgTU4W29h8FOtnW4kMvvIdjfq/Q8SQs3Gn1hvn6D+sAKn2It
	2hV5M8WkRk0aVTiRuhajxaOoxkoe+ZnLAZbZz9XAUGuaGByU7l6O6ebDkMRmtbRKiMYf7n
	cPNdTFT+Agt6K42CNrqXUMgY3gAKXjIcIuzVBa4VsGAtolgO99ozrfXrxpPRtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I33bwJEFFWyHGsdtr91jRQ3+9FS+jSE85doTBUJ8znc=;
	b=wOYE8K5btcY546cCxOFTNJwCDP/3hHbqHoFp24lcnuz0cXEfeppMTqVYSZN1VdLfQdwy36
	rDGXk8IytGg7EiDg==
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
Message-ID: <174653761805.406.9959711316955305927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     62ba4b718c7f032fdf418964916bb9cae291c5be
Gitweb:        https://git.kernel.org/tip/62ba4b718c7f032fdf418964916bb9cae291c5be
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:08 +02:00

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
 

