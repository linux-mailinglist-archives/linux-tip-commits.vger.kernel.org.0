Return-Path: <linux-tip-commits+bounces-5595-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068E1ABA3F4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F440A25A4D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E5C28151E;
	Fri, 16 May 2025 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kkDhbljk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FcEfJCko"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AC280CE4;
	Fri, 16 May 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424249; cv=none; b=BG5CHwm1Ch8DERU9HkHR34G8kw3IkS0jvnBtv8h0ZoBJtc3KU98+JpfwNocum6/9l22sJPpUpTsXmnffI13KR8b9Nfv/nlbHBFkqkVT8ZvYZnphhMyA6U60hrgXU7/XTJwhyG4cvijDMEhXHRT6pXZ9/ZA8+ANYN7LZDQz/cEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424249; c=relaxed/simple;
	bh=d0/2aF1edYzcAHqEprqCj7KiXBzyClMZC/AuDPD2ePE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rVjKojJeripi/BRExJnkqEJYEwVEYPKxlDl5NtbFlmLh+ev7DFwIkpT7yHAaWKc+Pa9LiP3fO1cbJH8etHMVFuJPEs9dtkGZzvknshx2P8G/uGV7hbdtMeP75/qp2ZPnyAK8RZH0CoV1BI34mwAsgStI7It7+eWbctKAce9/BfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kkDhbljk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FcEfJCko; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrWYWcks6na84epPIu0NwInLVUoghtA9Sc1GM3CvMEo=;
	b=kkDhbljk4YkQ4Ee9ALJFy1YzfaNoT+QXzRFrk21FTMF4JucMnG104e+LbDJVepDcNNA69F
	ty5sEzytJnhpq/0Tmyu+NSzfUV9i2dhxy6i8cqvacT/JUiPZWjVCZxsYzJ7tbpYi2PDXm5
	gcd4RO0lRXQ94WumB/dENp/OK5Q3Mv0hTt+raPZRyElPr/ZqUQhx+AdOnu20+zZZvD8dKN
	kDzZ0rAJWag7tSmwBKUJlZAX7Nxn89Q05Fsnq91c4/1yNInzo2DkBZlhp5kysD3W7qrtK5
	RFIDo/3iTDpBnhZdKOp7m0KWHTNN8odzLXu/F3DGyAZtLtzlFxkxZ7MYVXUAxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrWYWcks6na84epPIu0NwInLVUoghtA9Sc1GM3CvMEo=;
	b=FcEfJCkoCAdlx2tkTJbKjuxn0US2FAnANqOTDocHoRLMqybA7bAzkTAeGv9lnIgL4TeMl2
	jX4gNJ/Ua9DGDtDg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] gpu: ipu-v3: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-45-jirislaby@kernel.org>
References: <20250319092951.37667-45-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742424521.406.15235743194307643098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     e68664c08e3980f394d0bf22c64ce3cd2a3929e2
Gitweb:        https://git.kernel.org/tip/e68664c08e3980f394d0bf22c64ce3cd2a3929e2
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:12 +02:00

gpu: ipu-v3: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-45-jirislaby@kernel.org



---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 223e6d5..333f36e 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1008,7 +1008,7 @@ int ipu_map_irq(struct ipu_soc *ipu, int irq)
 {
 	int virq;
 
-	virq = irq_linear_revmap(ipu->domain, irq);
+	virq = irq_find_mapping(ipu->domain, irq);
 	if (!virq)
 		virq = irq_create_mapping(ipu->domain, irq);
 
@@ -1219,7 +1219,7 @@ static void ipu_irq_exit(struct ipu_soc *ipu)
 	/* TODO: remove irq_domain_generic_chips */
 
 	for (i = 0; i < IPU_NUM_IRQS; i++) {
-		irq = irq_linear_revmap(ipu->domain, i);
+		irq = irq_find_mapping(ipu->domain, i);
 		if (irq)
 			irq_dispose_mapping(irq);
 	}

