Return-Path: <linux-tip-commits+bounces-3613-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB6A44266
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 15:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C519917DBF1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D471426A1D7;
	Tue, 25 Feb 2025 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sbfhCibv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwgoIn9a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27D269D16;
	Tue, 25 Feb 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492963; cv=none; b=MRL4lEYlbQ/cqq8qQgPGkWp0yDnaUfBScyPoOE5YOt/C43jH5W/fycTQfpDm+BkRni48ocExNrlBhGm2+DRwKjbNhOd9LO6m/1uLXC4FE4DpdQ1KkVXN5JP5CdwmVTsTYawpwI1hS/piQwI5vfmAYdylyG9BDvGer3A7H0+8CiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492963; c=relaxed/simple;
	bh=ic89/Xr2wWnm4NQj9ULUvuHyJU+93/gzTZtcYCQygl0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MbWvOUz1JNFxW8SD6ZJjPWokaePT3BMFqwehDsV+2adVz3pQRh5UsRNp6eDkKagrmD34wokwWVBkyNapT3iTFNL+KR1424zUC/5kyOhlkUgPwFQ5Ay9DUacVrTpXNcv2ayqHearYgwvsR8EQNhJHouGWf/jb83chVH4HvxxL4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sbfhCibv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwgoIn9a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 14:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740492959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6pLXy4/8Mz5oIhec1RPb0DvC4iLxRtrz0XGKi6euhs=;
	b=sbfhCibv06GtrDG2rZTACGWgm6K+OxhzZauOjqv3rqfLX8FhJ0XK6K7ROETjxrpyG6QU3s
	Z8fyTK6To4sTbBrC6FbD2aqzYNsM/+ATIs/BnX9qr4sU+LACCYJEMFvFcCuMmSKHYVnW8M
	6owQN+ECezbhwXcLY3z1u1q6cv5KavndTniEZt2rTlYQYPA9Tw1MqyeH7/rXB/g3VfDqny
	Ez7p6PfJ23sVE1BQFWT53Vxu1Xc5sZFKAQsdy4BdiCnBWDsdITdWSMvk+J72uflqs3AzIl
	64NhbJw7mu7BWY8aDvG/SJ10bkSh/kyp8ECNMyD1dmQejVgt+UUHP48AXycLQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740492959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6pLXy4/8Mz5oIhec1RPb0DvC4iLxRtrz0XGKi6euhs=;
	b=cwgoIn9arTtGH2jxuOF2fUhfx2h7lJLChHGZkpBV+B70vb2OYaR/D54Gccif4bawHsXyYv
	hZ++7r63fSWT5XBg==
From: "tip-bot2 for liuye" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] selftests/x86/lam: Fix minor memory in do_uring()
Cc: liuye <liuye@kylinos.cn>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250114082650.113105-1-liuye@kylinos.cn>
References: <20250114082650.113105-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174049295877.10177.8031601958475058739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     c4f23a9d6e7314060ccf5f089eda179cdcc3b36a
Gitweb:        https://git.kernel.org/tip/c4f23a9d6e7314060ccf5f089eda179cdcc3b36a
Author:        liuye <liuye@kylinos.cn>
AuthorDate:    Tue, 14 Jan 2025 16:26:50 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 15:03:06 +01:00

selftests/x86/lam: Fix minor memory in do_uring()

Exception branch returns without freeing 'fi'.

Signed-off-by: liuye <liuye@kylinos.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250114082650.113105-1-liuye@kylinos.cn
---
 tools/testing/selftests/x86/lam.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 4d4a765..309c93e 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -596,8 +596,10 @@ int do_uring(unsigned long lam)
 	fi->file_fd = file_fd;
 
 	ring = malloc(sizeof(*ring));
-	if (!ring)
+	if (!ring) {
+		free(fi);
 		return 1;
+	}
 
 	memset(ring, 0, sizeof(struct io_ring));
 

