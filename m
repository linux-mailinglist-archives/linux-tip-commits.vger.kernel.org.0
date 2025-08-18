Return-Path: <linux-tip-commits+bounces-6274-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFFFB29F0F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E4C7ACBC0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4E315796;
	Mon, 18 Aug 2025 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vBsPYBTe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmkxaHIF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0062765DF;
	Mon, 18 Aug 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512556; cv=none; b=g/e8Y2I0voF/wK9Dj/5p6/Tp9uQGZ9HuX/vEprUiGz0LSo2wTrGlvytJIM9lA9rkEV2uHUizXO+wWT07gLVCfwUoFQdOpXU5VOwOvD98Gqqc8UsdFPJvE57K1DyJG8Nf09v9Id7CSBYmjpYnmWc1QVSFff0T35F85Hub1rulu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512556; c=relaxed/simple;
	bh=qFQ8wSqKPAJjB24u+E/UcdnIA+DSQTnoCigiNG/3a2Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k6/CcnLtmudGVC50Q6zgGYjEPFTEY4gFMumSGGJZpqA0WcrcMr5OMuWyTMX+Hg7basrUOcsk0ooPo6D11pjxKeEU50ufrzuC88CH5C+FkoZts8v+UsURyZ+riQBQqV1AXtGqTwVLOEi3Rtv4c3kAla43gvGp0A15ucQ1Cote2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vBsPYBTe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmkxaHIF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512553;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLwJCVHamk7nQloCqIFb4r3KfY25G5euJDlEgiYycVs=;
	b=vBsPYBTeIbWEONShc9uShGgGs5uR71F/4pkwcXCaA6+C13UFaUtfO2m5NVLWVIlHhO4wCx
	TxGSfv3Aq1PpnMQrnedFlrR9sXfvBmb57YeX2gooeRkmqMBX9nnNO9GmFkROKJtCFMI17T
	pAvfHY9Kld6vau0HGOjmcclaWvt8YTDfFrx0mmhO0I3K+5slv0bp5Erh3FuMx16y30ImiD
	DYuz6BkUzgf0GPrT7RI5TG1aBsoXrc74rDcvVyfTNzFf6RE96O2JlcDG3yxt2zgK43jgNl
	Bi7IjqVCwvWJo8KFV+N1Gq8ggv7LAyFnYCBzM0oxuLKRRKRt+yfcsa4qmIbVOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512553;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLwJCVHamk7nQloCqIFb4r3KfY25G5euJDlEgiYycVs=;
	b=xmkxaHIFIRvT2vjC/tV6gdcg0nC7CYNoDZDkRisyZBZgxa5PC/urknnI9GVfXqDpYqLcnu
	/KFPMtXjC7/0lGCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Move perf_mmap_calc_limits() into both rb and
 aux branches
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104018.781244099@infradead.org>
References: <20250812104018.781244099@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551255272.1420.14840460942887134777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     86a0a7c59845e7093c9c73a7115c9d86349499d1
Gitweb:        https://git.kernel.org/tip/86a0a7c59845e7093c9c73a7115c9d86349=
499d1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Aug 2025 12:39:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:12:59 +02:00

perf: Move perf_mmap_calc_limits() into both rb and aux branches

  if (cond) {
    A;
  } else {
    B;
  }
  C;

into

  if (cond) {
    A;
    C;
  } else {
    B;
    C;
  }

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104018.781244099@infradead.org
---
 kernel/events/core.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f908471..9f19c61 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7054,6 +7054,16 @@ static int perf_mmap(struct file *file, struct vm_area=
_struct *vma)
 			ring_buffer_attach(event, NULL);
 		}
=20
+		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
+			ret =3D -EPERM;
+			goto unlock;
+		}
+
+		WARN_ON(!rb && event->rb);
+
+		if (vma->vm_flags & VM_WRITE)
+			flags |=3D RING_BUFFER_WRITABLE;
+
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages !=3D 0, it's already
@@ -7100,17 +7110,17 @@ static int perf_mmap(struct file *file, struct vm_are=
a_struct *vma)
 			ret =3D 0;
 			goto unlock;
 		}
-	}
=20
-	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-		ret =3D -EPERM;
-		goto unlock;
-	}
+		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
+			ret =3D -EPERM;
+			goto unlock;
+		}
=20
-	WARN_ON(!rb && event->rb);
+		WARN_ON(!rb && event->rb);
=20
-	if (vma->vm_flags & VM_WRITE)
-		flags |=3D RING_BUFFER_WRITABLE;
+		if (vma->vm_flags & VM_WRITE)
+			flags |=3D RING_BUFFER_WRITABLE;
+	}
=20
 	if (!rb) {
 		rb =3D rb_alloc(nr_pages,

