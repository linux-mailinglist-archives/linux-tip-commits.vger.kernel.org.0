Return-Path: <linux-tip-commits+bounces-5679-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89C2ABF3AB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D843B0895
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619726560C;
	Wed, 21 May 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ynUzWTmk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mUVRrs54"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E753264FA6;
	Wed, 21 May 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829171; cv=none; b=EUNMKdcfb0NMGH+9y42Oq1c8qM+ltoXUMWY1iAdf775boXwEPDj4ggMjiwoETnTIfTKFtKWkGlVLIFs8Q82yVi32MfKIa0k2HXQpT19RO1Eao/sTaOHmuuOFiidJ+Orve3mz2HOZQqUL9esRU53Li7yK01GUaBRTC8Y6y9F78xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829171; c=relaxed/simple;
	bh=fElIRFETYZzr4Ifj+c9+g9RbSIsYDdiYEI5XALhK2k8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VkywhV1PxVVR83INWELcfYo1M08LR9D3PcFQIb95By88wq3giu/naw5fOcj2q6xhV9EtIgInGfN9X96g0bDWbqa4DHIsL1uFzhIKW90CIZsoolmQXp5TEL3LQ6wnACvMBpBp52ERIE6+wyHd7egOizbzw4wA9fkbN++5hZiT98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ynUzWTmk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mUVRrs54; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:06:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hif6vAmtKI+jSy7f55iVzWHZ92pzeGZk8llFmJ+6oy4=;
	b=ynUzWTmkn6xQ/j31/qrSYvZJSv/vllWroqu131GTK/UwlEV+YyWsozKosQvvs40FoDHSWD
	wk1zbER5+fhx23EdvNMCKDmmLDZjrzIQCRcIUnz4GSc5cqinqhFvjcKZwSO/46nyzZeDiV
	e+sU6nQz5lCZxZl63R7zu/x+2VhVhULvZxwbit0o2JSSsWeAOJHRCZwIG1WQ3SGXpNz1lj
	dJC5Ibv8LMILWU9bQN2TneroYUgReqhoPUYHKlpykG9eZZaFdYUJrGsHaGjkwaO72hFVrc
	dBMNyAy9va32kOZRdO4WdU921lD0qa6zjqn+uicOEDCiN5Wf2EpBv1MdAewYJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hif6vAmtKI+jSy7f55iVzWHZ92pzeGZk8llFmJ+6oy4=;
	b=mUVRrs54zpR7n2lvBxFfXxDdu0xhujabC17Q77fQfdyoyLeczocNNefpMBF/tI7eDMalgd
	5/LtCdlJCJHg+MDg==
From: "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Fix spelling mistake
 "unitiliazed" -> "uninitialized"
Cc: Colin Ian King <colin.i.king@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520080657.30726-1-colin.i.king@gmail.com>
References: <20250520080657.30726-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782916588.406.1506324316964417274.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     78272d44970c07899c78661f6b7492b5a7e14a90
Gitweb:        https://git.kernel.org/tip/78272d44970c07899c78661f6b7492b5a7e14a90
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Tue, 20 May 2025 09:06:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:41 +02:00

selftests/futex: Fix spelling mistake "unitiliazed" -> "uninitialized"

There is a spelling mistake in a fail error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250520080657.30726-1-colin.i.king@gmail.com
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index d18949e..20a9d3e 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -180,7 +180,7 @@ int main(int argc, char *argv[])
 	test_futex(futex_ptr, 0);
 
 	if (futex_numa->numa == FUTEX_NO_NODE)
-		ksft_exit_fail_msg("NUMA node is left unitiliazed\n");
+		ksft_exit_fail_msg("NUMA node is left uninitialized\n");
 
 	ksft_print_msg("Memory too small\n");
 	test_futex(futex_ptr + mem_size - 4, 1);

