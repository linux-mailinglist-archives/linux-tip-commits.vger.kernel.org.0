Return-Path: <linux-tip-commits+bounces-7894-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D03B3D177B6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBF203019562
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603483815E7;
	Tue, 13 Jan 2026 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tog4U7GN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f9fSdwyM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16053806DB;
	Tue, 13 Jan 2026 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295135; cv=none; b=ov4aeHRJkRCpcDMku/zJZSzeLnZSLlMyOBvd+lC6xwUCOBARAQKmGypf4EuDNeACI3zgzjZk+ZvjDtHF98cIV4jMNzbhujVl18Np92UhF/diVpn5uRPLoOxYpF1bTvUIXYTB1UXXw4PPqwK/m7ZS8MUtaQRADQqdxkc+zczIjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295135; c=relaxed/simple;
	bh=7gme1PC1+rCC5+ho//ALl9E7rVIvcAoI3Cj+9qe2TQY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=etX9jYVPXtgAy0hb4/mQbz5QE4fFPFK7dBRoM+UBB218EhhXHE2tvWv9n3KpemTQdsOgyh5dtne+19Ux5hUgFmfSXkTzekt+IO3Ah03w9oIGcxowzEG4of40bmlVs9lD7hEZJrWFo/cJAvAZk8iZkubCgJn1+2rasuJVj7ChY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tog4U7GN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f9fSdwyM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 09:05:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768295132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9cwhdtR6zM/pAozu5QdvKr8PB1gn07cJL1lz9EFYJI=;
	b=tog4U7GNEaFvmw7ySK9KqKAi4/xfC5zf+vTiAP93Q83OajYUXwCUSurRzwBcy8i6rMUJei
	fIDxLzKG/M7UeLrHJFEj9mGhPrnH03lUOdm1fDI2iGBT7rmE0SInHliVppqmwrCJLun1Na
	yPjEyRBvKIWEydz0aGiUoaqeTp3GosxcRcWOE8stIJ7e/yVpX7OMIxf+lGJyzljoMO3x4M
	mS0eqtyVbBMOjTjPRNCjKROWAuEGEC/4o/sw6Aj6c81bb3NvSM/LoGDfJEXrmQIyokiXZM
	9T408skyfcqLERr/RWv/wHJIoeIxsKGzMTQXyKFTMkV2GZjMRfAN8sYso6URyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768295132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9cwhdtR6zM/pAozu5QdvKr8PB1gn07cJL1lz9EFYJI=;
	b=f9fSdwyMNPa+CTOVsnGVu0GdGblSyyWiJmfh+uHC9ExJrBtsn2vs0JxGnC8cK760nLfaRn
	BPW+BLqGDPCdkXAw==
From: "tip-bot2 for Radu Rendec" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] genirq: Update effective affinity for redirected interrupts
Cc: Jon Hunter <jonathanh@nvidia.com>, Radu Rendec <rrendec@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260112211402.2927336-1-rrendec@redhat.com>
References: <20260112211402.2927336-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176829513066.510.945580505741386122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     df439718afaf23b5aa7b5711b6c14e87b5836cae
Gitweb:        https://git.kernel.org/tip/df439718afaf23b5aa7b5711b6c14e87b58=
36cae
Author:        Radu Rendec <rrendec@redhat.com>
AuthorDate:    Mon, 12 Jan 2026 16:14:02 -05:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 09:59:28 +01:00

genirq: Update effective affinity for redirected interrupts

For redirected interrupts, irq_chip_redirect_set_affinity() does not
update the effective affinity mask, which then triggers the warning in
irq_validate_effective_affinity(). Also, because the effective affinity
mask is empty, the cpumask_test_cpu(smp_processor_id(), m) condition in
demux_redirect_remote() is always false, and the interrupt is always
redirected, even if it's already running on the target CPU.

Set the effective affinity mask to be the same as the requested affinity
mask. It's worth noting that irq_do_set_affinity() filters out offline
CPUs before calling chip->irq_set_affinity() (unless `force` is set), so
the mask passed to irq_chip_redirect_set_affinity() is already filtered.

The solution is not ideal because it may lie about the effective
affinity of the demultiplexed ("child") interrupt. If the requested
affinity mask includes multiple CPUs, the effective affinity, in
reality, is the intersection between the requested mask and the
demultiplexing ("parent") interrupt's effective affinity mask, plus
the first CPU in the requested mask.

Accurately describing the effective affinity of the demultiplexed
interrupt is not trivial because it requires keeping track of the
demultiplexing interrupt's effective affinity. That is tricky in the
context of CPU hot(un)plugging, where interrupt migration ordering is
not guaranteed. The solution in the initial version of the fixed patch,
which stored the first CPU of the demultiplexing interrupt's effective
affinity in the `target_cpu` field, has its own drawbacks and
limitations.

Fixes: fcc1d0dabdb6 ("genirq: Add interrupt redirection infrastructure")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Radu Rendec <rrendec@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20260112211402.2927336-1-rrendec@redhat.com
Closes: https://lore.kernel.org/all/44509520-f29b-4b8a-8986-5eae3e022eb7@nvid=
ia.com/
---
 kernel/irq/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 433f1dd..35bc17b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1493,6 +1493,8 @@ int irq_chip_redirect_set_affinity(struct irq_data *dat=
a, const struct cpumask *
 	struct irq_redirect *redir =3D &irq_data_to_desc(data)->redirect;
=20
 	WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
+	irq_data_update_effective_affinity(data, dest);
+
 	return IRQ_SET_MASK_OK;
 }
 EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);

