Return-Path: <linux-tip-commits+bounces-7008-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B64C0F546
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7D71893697
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFC9315D4F;
	Mon, 27 Oct 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fGvqpZ4c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdeGHEYp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632E31354E;
	Mon, 27 Oct 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582664; cv=none; b=Tj3Lzwgwbp/6t9ayN6ZYtG0Wiz4Y+wguarctfcLUJwSXw5JzaJZW3JB6PYGzTq9kbTL6yXVTH/lMuOfgzppOA8zYsVNdRl9kogGANMQr8krRtdSptMREXYNPaxCDSQ0Yaheagaz3xqTkrfe5XhxiquPhiYFvW5x5M2FBfxTGhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582664; c=relaxed/simple;
	bh=hFJL0W6aJ7JlErg++aDEkC9lCMLHvSrBGDEYkWfXb4M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fgL/X1N4kqPq/3vc74ORMrYEfWG/2qQB7aPOJcyCWCWkrwnAL6df2Kn04bFgT6yUFU9RJOBfdji0r6xPJMaVDoNqIJhX8q3sA654Wm34d+625n/S1BhwhK/xB29utrSoadmsm6fbEk6+/KcqLCzzv+K8ZzD3YJ/oOBmWkmaTaUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fGvqpZ4c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdeGHEYp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:30:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikqx0xAA4YVm7ppwYIID2Cyc9e1tVq07XKe6CSW+v+8=;
	b=fGvqpZ4c/BLSW1nPH3KpoPNvuB4A1Q6UG+36lHMdmHrlYI8VXoXOJDB1ZhdohIybA+wn97
	qLc98R3WWzRcZ+WaRj9mqV1qDxVoXkN4Z0kxPCg8zIfGGrzBM6igInjXgp+3NDI+SX6yHW
	i+XFVVkc0G+rycoQwKPyy967Rxt5lk9p9tPofheN2BBCpC6puGJlkF82W0hsk7pGRZymcp
	DfPP6x/syeDs4c603Sz9sxBseSqYxDKhBLEQtDksa1k+2TAjohRZApNj3OIcCgs2cWHxxR
	knetwsAV3yLtra6+qdujNjszPgamDgAMTw0YDSm/qZ2awlLlcwWGvjz3Suju1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikqx0xAA4YVm7ppwYIID2Cyc9e1tVq07XKe6CSW+v+8=;
	b=rdeGHEYp5idOocaKXx7wUlNzmD1sdYNZgVbYjtAsoEIN8MOCKzaOX4iwx9OSNraLNNWIK9
	eQCTAlCI/dbI5MAQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] perf: arm_spe_pmu: Request specific affinities for
 per CPU interrupts
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-20-maz@kernel.org>
References: <20251020122944.3074811-20-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158265998.2601451.3908214788174365212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f8112d29ba992e51e4789844340f7da4bdca5fcb
Gitweb:        https://git.kernel.org/tip/f8112d29ba992e51e4789844340f7da4bdc=
a5fcb
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:36 +01:00

perf: arm_spe_pmu: Request specific affinities for per CPU interrupts

Let the SPE driver request interrupts with an affinity mask matching the SPE
implementation affinity.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-20-maz@kernel.org
---
 drivers/perf/arm_spe_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 1460b02..87908f0 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1259,8 +1259,8 @@ static int arm_spe_pmu_dev_init(struct arm_spe_pmu *spe=
_pmu)
 		return -ENXIO;
=20
 	/* Request our PPIs (note that the IRQ is still disabled) */
-	ret =3D request_percpu_irq(spe_pmu->irq, arm_spe_pmu_irq_handler, DRVNAME,
-				 spe_pmu->handle);
+	ret =3D request_percpu_irq_affinity(spe_pmu->irq, arm_spe_pmu_irq_handler,
+					  DRVNAME, mask, spe_pmu->handle);
 	if (ret)
 		return ret;
=20

