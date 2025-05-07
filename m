Return-Path: <linux-tip-commits+bounces-5336-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBECAAD97C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C4B3AD199
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F49225762;
	Wed,  7 May 2025 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cym6uFhU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vipMArDE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C8224227;
	Wed,  7 May 2025 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604678; cv=none; b=ZeUm0vupeDfUCjjRQOP8TUugNZIRyT9kAM5UxCp3QIQWvQXWW+7Nii3RyYW3bd+xAEO1VlKjnolNbDchaZgrqeDn/AnAKxKKe2vFUpE7AKDn4dDJzEZ000ZA/FPb6CzUcHYQ4sIzi8/EwwOqRwMrNf4o/Mkhy3eReYDDygyiD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604678; c=relaxed/simple;
	bh=e/62T7/YkJj2wdEF6ny+lDHd1eDo6T3hZ2LfeGD+kK0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nIl1i1q13xjOOfpA9VHb5j1SRxQYhnC1T9ujqGA13F+k4otiscNJ+DlpUGcO7F2SUBWr0ITRYRSdRG/acwAnODNarOevnHPp9B2H3AQ9sY0/LNf6GZSGQLWYJxDmiGCwCyFnWmuTiLWQYZ8EX0KcQr+5Qb6A0iTSmARfzJmL+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cym6uFhU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vipMArDE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHWzM5FYXEKclpw0Lxl44IZkMETQ/U2XCFr0253huwE=;
	b=cym6uFhUnBreXeQmrJV1KLhUuwq5jbGRdDTOPB2nm1dIJer8kU8cySecY5RPddlW2qZmAG
	3/jeq55i7mkUUJKgYvyb0H8k/jmC5GGmdYsubi2Ud7PoVU9HhxrJnOJdChDsJoD+haclwv
	X8NPL6bhW0SyzIEy/iXEAoQDRXQSA/YyZimOcCvj9LI6MH8798/w9UgkV9Rj4IHwwORmby
	jKJwdk8jEpQe8UTePuQBo84XP7idKwthG/NCigEY5Wihj2jc5MmUcXAuzH7/p5LAE955R4
	EiLsnyVhFrp+F5APuUX0amvc+clgaK58ONxWf/CrZ/4eWTVIw0S37SmeRT4kxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHWzM5FYXEKclpw0Lxl44IZkMETQ/U2XCFr0253huwE=;
	b=vipMArDELOF1lEspC5HCEpLiI839k1KuMFLWHICcZREHScT9slIN7bjC5ex6ySm6joPI8d
	J9DZvrE3NsmpU/Ag==
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
Message-ID: <174660467424.406.1323573107426302413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     9195834aad740c8f4550bdda89a7152c3f5d0d32
Gitweb:        https://git.kernel.org/tip/9195834aad740c8f4550bdda89a7152c3f5d0d32
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:24 +02:00

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

