Return-Path: <linux-tip-commits+bounces-5933-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB1AAEA915
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 23:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247FE174DDA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B474D2609C7;
	Thu, 26 Jun 2025 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YzBdq+Ad";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFHsHVx/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071271DFFD;
	Thu, 26 Jun 2025 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750974947; cv=none; b=N8wDbgnAj4pzKHwIoIvDceA7x9gQD9ET6gwX8QO1lIsIHPpAXi1FMYgAkAfix8pPyoNXttnkuufqs+BuqdX1lXxRbwfDVlNGDONMOtM1cRVzkOdWERyQud5NzHuy4IOKvmsoRBrUh2spW3OcpYOfGXjU4SXcbe0O9oebPbjsh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750974947; c=relaxed/simple;
	bh=qF9czqDhxawPdqrvxxDTcY4lq70ZNK7bOzfSfzDY7yA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YqrWMZxBO+YkwUtVe7a4206UJ1uKUjbn0UJg9iTrli+MWTlmF4OKSWiwGPv2PDchRi/1VsGJcIdd59ik/7w5uinOjkPCWiYIcqJ4b7a54txqnkpj1RKohlLhsH1LHBZdlLEHxo7jJbFeUCVszRveiUmD5P5zSNvvy1zrKqbPsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YzBdq+Ad; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFHsHVx/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 21:55:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750974944;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFKL+7pqrxn2xKTof2rje6ugem6bo2cL7I9FGjghiHw=;
	b=YzBdq+AdNNYV2zX2w/UTD4nvnQjyLT3Ndv0Jrw3zEOxpoKtnFY8t2hiugVQ9kccV2yA0OO
	hnPpG2bO4/zO4NqklC2CGVkZOoQvqCkORIRVnRFDJF0xH74inrBqpiqqxseVDApWoLQUp7
	Oj4EPEqfgZSN/f9k01eN0IIZn/RNumvQp2tlsa+56VFmLTY9Lv+44uC91oxQoubiyc9HNd
	Xj1Puw1pLO8SNxtqRina9FH4DBCxJbbpL6BAx/FmboVXwbDdMPgPd/hedwajo6MadPMTqK
	S3aRPJFb440JBBLPmgv0o1q5aMmbep92Xywb+vpcQxJlmE+Oq5hWPliuFygc4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750974944;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFKL+7pqrxn2xKTof2rje6ugem6bo2cL7I9FGjghiHw=;
	b=iFHsHVx/SS7tbbFtdZ4YghP98cH5og/NBqIjY8ed+l0IpEFp0YoYMiYm9RPb5uKDp8Cau3
	9g3p6W9xMwYB0UBg==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Don't wait for remote work done if not needed in
 smp_call_function_many_cond()
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250623000010.10124-4-yury.norov@gmail.com>
References: <20250623000010.10124-4-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175097494304.406.14949887144517202475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     a12a498a9738db65152203467820bb15b6102bd2
Gitweb:        https://git.kernel.org/tip/a12a498a9738db65152203467820bb15b6102bd2
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Sun, 22 Jun 2025 20:00:08 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 23:46:35 +02:00

smp: Don't wait for remote work done if not needed in smp_call_function_many_cond()

If there are no IPIs sent, then there is no need to wait for a job
completion of non existant remote execution.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250623000010.10124-4-yury.norov@gmail.com

---
 kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index 5871acf..7151906 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -849,6 +849,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
 			send_call_function_ipi_mask(cfd->cpumask_ipi);
+		else
+			run_remote = false;
 	}
 
 	if (run_local) {

