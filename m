Return-Path: <linux-tip-commits+bounces-7119-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E01C270E4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 22:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8537818914AE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77782F6191;
	Fri, 31 Oct 2025 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ouxNdgvn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9WFo/7oR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433930BF79;
	Fri, 31 Oct 2025 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946639; cv=none; b=ASX5DJI2T/KcUm+pdbrB/gYTAFIfJa0zTLHXfzvxWoa+8dm6v18/9H7TQxLIsSW1vc7lIhMae3e5qeISQxz25vzMEz9b9k1sEf/upMwG9j9b3ZqmPtgM71sSWWbAaglX7eB1VG9S9MgRw2Ft4Zh22r3Ft4QZLcvb28QTBrPO2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946639; c=relaxed/simple;
	bh=QVR16KIfLQSszHkZDKUW/HCpmS6heSz2hEldpIxegJs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cvNy7vj/jRuinmhhPT93fAkD1aaucUUfNc0MuYm+LOHWfEwvg1+47RB7G6XWXILVFk9z8RxocG2iCC0hf39sxO2oML/o+S8fl+2vpUoi04z8rNIjwt9jYhHV6sCyBIU5aGMZVVPhI7SVG9U5Eq4TYR6E9Td/qBEWPC86p/MJU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ouxNdgvn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9WFo/7oR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 21:37:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761946635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z60cZ4V1QRhSqqkrNsWyT2gTmvf9b/JCSVBJ+ckjfgA=;
	b=ouxNdgvn1wjjDHgseIqL/frWIc/ZIbsoNT/aXJ8siMDY+GJgfex5sFbmdpmAK7c7fWYE+Q
	kFZ1GpgAOlgrIGzuctv9PQxovci11FOWRAUZKR2CFAvxD5Co+9WKgyW21/ZNstRJp6GPBn
	quzFb0+aL+RKua1H/L1Ofi1P8G8Aigxyw/igw/lY6fs1iD6z+F31TNZgpKPD/0YQJCd9Qp
	EtxUR81Dt0Z3w26F03YcEvAnR6s9xgS8b/PWrmNxK1+CCkwy+pj93Kk6kqSV8SdgR+NWz2
	AMxOtP9UsY4unNuvhbp7o1qZwW5HjEA+Ay6T5IqT/zpOLEnVGOHdrDZzft810w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761946635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z60cZ4V1QRhSqqkrNsWyT2gTmvf9b/JCSVBJ+ckjfgA=;
	b=9WFo/7oRaUysVP+pSP8s4NNsRywUTT7wBjLX4EoTwfG8XuioEi6pSroYXWejKMjs8+/LXY
	AFhhDpq9OY2+iPBQ==
From: "tip-bot2 for Muchun Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/proc: Fix race in show_irq_affinity()
Cc: Muchun Song <songmuchun@bytedance.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251028090408.76331-1-songmuchun@bytedance.com>
References: <20251028090408.76331-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176194662566.2601451.1527641984431803773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9ea2b810d51ae662cc5b5578f9395cb620a34a26
Gitweb:        https://git.kernel.org/tip/9ea2b810d51ae662cc5b5578f9395cb620a=
34a26
Author:        Muchun Song <songmuchun@bytedance.com>
AuthorDate:    Tue, 28 Oct 2025 17:04:08 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 31 Oct 2025 22:30:05 +01:00

genirq/proc: Fix race in show_irq_affinity()

Reading /proc/irq/N/smp_affinity* races with irq_set_affinity() and
irq_move_masked_irq(), leading to old or torn output for users.

After a user writes a new CPU mask to /proc/irq/N/affinity*, the syscall
returns success, yet a subsequent read of the same file immediately returns
a value different from what was just written.

That's due to a race between show_irq_affinity() and irq_move_masked_irq()
which lets the read observe a transient, inconsistent affinity mask.

Cure it by guarding the read with irq_desc::lock.

[ tglx: Massaged change log ]

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251028090408.76331-1-songmuchun@bytedance.com
---
 kernel/irq/proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 29c2404..77258ea 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -48,6 +48,8 @@ static int show_irq_affinity(int type, struct seq_file *m)
 	struct irq_desc *desc =3D irq_to_desc((long)m->private);
 	const struct cpumask *mask;
=20
+	guard(raw_spinlock_irq)(&desc->lock);
+
 	switch (type) {
 	case AFFINITY:
 	case AFFINITY_LIST:

