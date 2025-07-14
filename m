Return-Path: <linux-tip-commits+bounces-6102-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB8B03A63
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C313A6990
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC24523C4FF;
	Mon, 14 Jul 2025 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vFghcZJX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3DR2Poj4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4BC230BC6;
	Mon, 14 Jul 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484240; cv=none; b=jYE9occ5J7IB7aul6T9DtIwgsKAcmvjRwKQVvpfscl7JWYcgzisCXP9m+ahsxto9etcmRL8QQY3tgoog58FCpdOBMfJYOzCB0bcQsdB2YFtqy5S9X3fSeNn8oYw51BMtz890Ujg1bSBNLENV2flSxLFRc9YH0y9lqc0jyl3Fr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484240; c=relaxed/simple;
	bh=uEhx5nzK+jcrdPheySdYCg12qiNvHYxDwktwJrpH0+s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V402BP88zGYq6XJg7ufnXf/jrPh2fPJ8jsSvZOSlaPEkY7pMfOiXjx5WIGwq76ylU53n7vDTf6F8gcur08TbcT/Xk53D05js5qy6CqYtksRIZjpwNTZwOjb1mS+oELV+9UDLDmyOrDFr3rPGjHffmFM1/Wtm4Mm5cYx8I1Yje80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vFghcZJX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3DR2Poj4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmXHAGc5OBhN1MOVu64h5Oh8Y5voaUftXnYZEthUYx0=;
	b=vFghcZJXqcr28lUJl/FB4f0Yl/sirgiVhY3/Dxzc/2SOcDaoHo7ueg1ysCpDmZGlJF/Ua2
	JL4RRPaxMw215yB6/nmVFIdtTKW4kmj6tLQdV9/As22t/Xk8PN8c8duaaUm835COh3GUB2
	NIGdZd67SZMbwLyCNqam51fBKOqBWeY4UFzEP07ZzFN2j2lJfmT4SvNhtqEXIZsUjP/rAa
	v3yLyq4y44YpjUWiTHuyg9HxNNhK5aGKUEv4RgarzHyas+Eo02a2n8iL09kSaIzC47tKeq
	HFruQbxyXjCnnUQhB0OPCSVhtCvEgxTYmfEVTuMrRT1jNNyoZs3ZEe08OHdaXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmXHAGc5OBhN1MOVu64h5Oh8Y5voaUftXnYZEthUYx0=;
	b=3DR2Poj49qDlvpBeL8GE2Ss6+Q+p9P5yt4/AuEkmaEAKMp2cZ6iJBUXDZ6CQ3Ldag7WLED
	rbVNVDpy+tTUVFBg==
From: "tip-bot2 for Li Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/smpboot: avoid SMT domain attach/destroy if SMT
 is not enabled
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 Li Chen <chenl311@chinatelecom.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710105715.66594-5-me@linux.beauty>
References: <20250710105715.66594-5-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248423527.406.9048774220593018481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f79c9aa446d638190578515afcd06d6c9d72da55
Gitweb:        https://git.kernel.org/tip/f79c9aa446d638190578515afcd06d6c9d7=
2da55
Author:        Li Chen <chenl311@chinatelecom.cn>
AuthorDate:    Thu, 10 Jul 2025 18:57:10 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:34 +02:00

x86/smpboot: avoid SMT domain attach/destroy if SMT is not enabled

Currently, the SMT domain is added into sched_domain_topology by default.

If cpu_attach_domain() finds that the CPU SMT domain=E2=80=99s cpumask_weight
is just 1, it will destroy it.

On a large machine, such as one with 512 cores, this results in
512 redundant domain attach/destroy operations.

Avoid these unnecessary operations by simply checking
cpu_smt_num_threads and skip SMT domain if the SMT domain is not
enabled.

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250710105715.66594-5-me@linux.beauty
---
 arch/x86/kernel/smpboot.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8038286..412c813 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -492,6 +492,8 @@ static struct sched_domain_topology_level x86_topology[] =
=3D {
=20
 static void __init build_sched_topology(void)
 {
+	struct sched_domain_topology_level *topology =3D x86_topology;
+
 	/*
 	 * When there is NUMA topology inside the package invalidate the
 	 * PKG domain since the NUMA domains will auto-magically create the
@@ -502,7 +504,15 @@ static void __init build_sched_topology(void)
=20
 		memset(&x86_topology[pkgdom], 0, sizeof(x86_topology[pkgdom]));
 	}
-	set_sched_topology(x86_topology);
+
+	/*
+	 * Drop the SMT domains if there is only one thread per-core
+	 * since it'll get degenerated by the scheduler anyways.
+	 */
+	if (cpu_smt_num_threads <=3D 1)
+		++topology;
+
+	set_sched_topology(topology);
 }
=20
 void set_cpu_sibling_map(int cpu)

