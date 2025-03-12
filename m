Return-Path: <linux-tip-commits+bounces-4137-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22EA5DC9A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 13:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090E0188143A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 12:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD2B24168E;
	Wed, 12 Mar 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jnbn6wNv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9/wq7m8r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E6242904;
	Wed, 12 Mar 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782523; cv=none; b=oz/h5EYgxnYPzWph+GmBnmPLMayeHvwlYZLjB2I1tibd+j1g/2+f7m9VkAv77qPxQQ47OkLN+kIOKqHGOT05i/3F8ntaBENGULWNbMTyb73YTh72ESGrdRxuvILr5KOn3M9y/2fFBictloOhm/qMGrBgJ418m7+Xg8+ud0faLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782523; c=relaxed/simple;
	bh=fwrc6M4qXhaEOVjR4JqH4N0wgiIUdIuiVJj3fQdySx0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R7JpSq/0Iqsu6tMhxUBKshS96mmx/kKCK8ZVPJ2Mly99gFY6qd2Qb+NUuSHf7/8FM0l69HQYZYpsOeuoFdhTdUv7N1QP+75zGWGN60xxSSby73AYPb3ZZdBFQHRBXAro1OKIUdlDEyqGFYadCAYlKfgNMiqaz7wNVtZDAZ2T2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jnbn6wNv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9/wq7m8r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 12:28:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741782519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1k30LnTqDxFUV7OJnGma3P9w7ZhDeZEpwubjz4wnmg=;
	b=Jnbn6wNv12CUhwD4cOXJSS+Pw2LKd/cI5UR1CYFRPT2LeQSdnnH7V43P6N1ZR730RYhz3H
	pQ72g+37Kzyz3IfASm5B5xMl3zPo2dP/TKUKBPSUUiiV8AU4JO+WqWLYXf/PBsuzLXoHAg
	DaTH3rvSyK/TlFa912UGmkmuooHgyB1zdbiErI6+6GQTPLmWsyzwWdFAz8wNhTSe7VgEHl
	2upPpwMbJtQidRwDZzrMqB2f/eBD66Ez9UI3nwkaz/VVpreik0YdcRNZ/W3dHPJf6VVUbj
	z87w7DapmZ1dV4lEyPgyEwzJzbY6KAR0RC/jXIUuFUBgqKQfnHenN9w0euCzXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741782519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1k30LnTqDxFUV7OJnGma3P9w7ZhDeZEpwubjz4wnmg=;
	b=9/wq7m8rEfOP3hPeyYWC233Ry7/RYPdh44YoyTHQ0AICciHdLZwYmGuuLLqQ1uuL4LiqO0
	nWpPlrirv1QNGeCQ==
From: "tip-bot2 for Michael Jeanson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq/selftests: Ensure the rseq ABI TLS is actually
 1024 bytes
Cc: Michael Jeanson <mjeanson@efficios.com>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311192222.323453-1-mjeanson@efficios.com>
References: <20250311192222.323453-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174178251820.14745.7415205705924432545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e6644c967d3c076969336bd8a9b85ffb45f677f7
Gitweb:        https://git.kernel.org/tip/e6644c967d3c076969336bd8a9b85ffb45f677f7
Author:        Michael Jeanson <mjeanson@efficios.com>
AuthorDate:    Tue, 11 Mar 2025 15:21:45 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 Mar 2025 13:19:47 +01:00

rseq/selftests: Ensure the rseq ABI TLS is actually 1024 bytes

Adding the aligned(1024) attribute to the definition of __rseq_abi did
not increase its size to 1024, for this attribute to impact the size of
__rseq_abi it would need to be added to the declaration of 'struct
rseq_abi'. We only want to increase the size of the TLS allocation to
ensure registration will succeed with future extended ABI. Use a union
with a dummy member to ensure we allocate 1024 bytes.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/20250311192222.323453-1-mjeanson@efficios.com
---
 tools/testing/selftests/rseq/rseq.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 1e29db9..6d8997d 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -71,9 +71,20 @@ static int rseq_ownership;
 /* Original struct rseq allocation size is 32 bytes. */
 #define ORIG_RSEQ_ALLOC_SIZE		32
 
+/*
+ * Use a union to ensure we allocate a TLS area of 1024 bytes to accomodate an
+ * rseq registration that is larger than the current rseq ABI.
+ */
+union rseq {
+	struct rseq_abi abi;
+	char dummy[RSEQ_THREAD_AREA_ALLOC_SIZE];
+};
+
 static
-__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"), aligned(RSEQ_THREAD_AREA_ALLOC_SIZE))) = {
-	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
+__thread union rseq __rseq __attribute__((tls_model("initial-exec"))) = {
+	.abi = {
+		.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
+	},
 };
 
 static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
@@ -149,7 +160,7 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq.abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
 	if (rc) {
 		/*
 		 * After at least one thread has registered successfully
@@ -183,7 +194,7 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq.abi, get_rseq_min_alloc_size(), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
@@ -249,7 +260,7 @@ void rseq_init(void)
 	rseq_ownership = 1;
 
 	/* Calculate the offset of the rseq area from the thread pointer. */
-	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
+	rseq_offset = (void *)&__rseq.abi - rseq_thread_pointer();
 
 	/* rseq flags are deprecated, always set to 0. */
 	rseq_flags = 0;

