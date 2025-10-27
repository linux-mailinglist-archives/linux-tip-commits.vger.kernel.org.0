Return-Path: <linux-tip-commits+bounces-7010-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0861C0F5F6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32409482133
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619831691B;
	Mon, 27 Oct 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qvDy7ck+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A4JvMvq9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049423168F7;
	Mon, 27 Oct 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582668; cv=none; b=k8ONOOZlVWfFMW2T2LhU17MH9TXg4DaCEd5oL+7lBZRzWyaSR6MnRkJhYyi6JmUoGAPUUtEzFR0ib1+ChVct349R6r2/rCmq/+lC90CSKD9UWgcmhbflXl4azrbRK/Vf290THV/OpEVSQe672lCfwkJB7GqxxZwgTs1CTYPjSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582668; c=relaxed/simple;
	bh=4I33X6q8ogJX/LFYS/dK+7I3IMRjAPz4Vf5pbiFPhiI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A7w2F8OqrNc6v8V3nox24MSx0wd31p9rkZ80EgS5jbpfUF1mT8sgj4xOm2a25MuGkLHFsaogtpE+lNFVJeobZLlY1pEYOc63/0vCbcJamHbBcYIZ6gtFq187GpxPhPpne/x8XbJfvwn/fwmCPXRL539XjJpD5G0mKazxBSBVxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qvDy7ck+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A4JvMvq9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmUJTZZcVIzvn7qjYHZva5XmgWz6IKLzOXRCRynUv7o=;
	b=qvDy7ck+yjWBVZdLNZrI7QO6ScbKHRIwh4/Vghqr+/FQXgmgaSczLaM1x4/4jvmylq/sq4
	m2lMaqXHNZSvmboo60D0LASqKmlaf5zdftPnUAcqIICmUXiO+Ea5HUHmlunE2m5L6Z8mI0
	3Nf+3H0oXIwxRPNnLeSzq2At/zZ8SnEr/kxaqN3ZnpkwlLkgmsTeNcA/gqCjcPQUeSV84U
	kAd2qrZRfUKvz6cTGAJl8bNHSU1Qxc0HIGjDsArQ4HotAPXLh7SxDPUCxI/CDxMLoPTdTn
	JkNfC+ZwtMiLm7Z97+6cgJ50bkK/4Sv5E8Im0rUewV8Ee8l7PW/rJDQrqR/vqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmUJTZZcVIzvn7qjYHZva5XmgWz6IKLzOXRCRynUv7o=;
	b=A4JvMvq99sjyT6LDF3MJnxZFpixyO9sEFnpKpVwciG/BgUaV/GQM/BngFVp3c33eee3jmt
	3MOWYz6sbOz2NhAw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add request_percpu_irq_affinity() helper
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-18-maz@kernel.org>
References: <20251020122944.3074811-18-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158266267.2601451.8012172575828054332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c734af3b2b95f0ac6ed87c50e7602a6beeaf534f
Gitweb:        https://git.kernel.org/tip/c734af3b2b95f0ac6ed87c50e7602a6beea=
f534f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:35 +01:00

genirq: Add request_percpu_irq_affinity() helper

While it would be nice to simply make request_percpu_irq() take an affinity
mask, the churn is likely to be on the irritating side given that most
drivers do not give a damn about affinities.

So take the more innocuous path to provide a helper that parallels
request_percpu_irq(), with an affinity as a bonus argument.

Yes, request_percpu_irq_affinity() is a bit of a mouthful.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-18-maz@kernel.org
---
 include/linux/interrupt.h |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 81506ab..fa62ab5 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -196,6 +196,15 @@ request_percpu_irq(unsigned int irq, irq_handler_t handl=
er,
 				    devname, NULL, percpu_dev_id);
 }
=20
+static inline int __must_check
+request_percpu_irq_affinity(unsigned int irq, irq_handler_t handler,
+			    const char *devname, const cpumask_t *affinity,
+			    void __percpu *percpu_dev_id)
+{
+	return __request_percpu_irq(irq, handler, 0,
+				    devname, affinity, percpu_dev_id);
+}
+
 extern int __must_check
 request_percpu_nmi(unsigned int irq, irq_handler_t handler, const char *name,
 		   const struct cpumask *affinity, void __percpu *dev_id);

