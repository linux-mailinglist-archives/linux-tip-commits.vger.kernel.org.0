Return-Path: <linux-tip-commits+bounces-4117-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C491A5A436
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 20:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784EC167818
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556BF1DD525;
	Mon, 10 Mar 2025 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3SbeLVv1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERBjMpka"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C71DE2C7;
	Mon, 10 Mar 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636749; cv=none; b=pBDPJgXIlnGUyXPnVHkP7KTnL0E1xrNKDpwGqcMYZ9Yityw0rfAE6U4Etxv0ztmsuyvnLy4yv+DgZQyPlIzIah3STYX4nArqlxrEmXGkrtB+xUndRv71mp+5CdBQiaXcD3kZL/h439YaGvXS3GargFXyJBn1EtoLckw+yhh7d7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636749; c=relaxed/simple;
	bh=H5ycHYupR28l1HqDSyLBg9rTOcsIGNw4x4qnabynmmM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VSekre8FiCnh/eHev1zXSnMCsQXSnbI0lsNLP+vgzJWPQ4+t+MhaTo8eDGYlPT8IWJkBr08f+eXpAGO7UjQU1ObDPZyXQR3ne+EB/Jrr9gHCts5XcvUSkUSlYSSab5rQoOGOQuBMtfyIaqgoHov1wLmbFpHeYytQPCSFzYkZ4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3SbeLVv1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERBjMpka; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 19:59:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741636746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLGE1KdgCPQhUtvXDXBlsuV2cfjDAG5GjUb0ed3g0a8=;
	b=3SbeLVv11xKGSdx6ouLcfcYMFTE+OctQlV7xqzUDglkuieS0pqg5NF2rYsKEuAqdTO72qG
	V3IZ4PZnosx0r8nhkWcFotynMRV7nBUFzLBX4/Oc/Rx4jqqC4qtfFHIf9PofmIr8jyVir5
	9Oe+J+mQc9Yv/pEZyHACxcFfbB3O9m+xg6JqQvhtq9JMEzvI/1rO3qv4q89y0HFhihr9FL
	9qVJmaYl4yABsqCxpTL0wjvWwzaQcZS51KInydJkVHvzeAavFTUvkrEV5PRnz7JaZStR7w
	7bXSzOGVHLw7sBY0W50KXScY2cYmdMfIZjJs+qzXtZV7CPVoswUdwIsRV8WFoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741636746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLGE1KdgCPQhUtvXDXBlsuV2cfjDAG5GjUb0ed3g0a8=;
	b=ERBjMpkaI3HlSlM+1HMdfFEb9hY6loJPHSakz/UY8ZxxpgvGR5gubuimWUWDbfwySs8Axq
	SdvQATqtC4tamODw==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Remove optional 'size' arguments from
 strscpy() calls
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310192336.442994-1-thorsten.blum@linux.dev>
References: <20250310192336.442994-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174163674500.14745.11511940835737633546.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fd3f5d385a52531589c8a7a26d9e108aa1d3f52e
Gitweb:        https://git.kernel.org/tip/fd3f5d385a52531589c8a7a26d9e108aa1d3f52e
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Mon, 10 Mar 2025 20:23:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Mar 2025 20:50:30 +01:00

perf/core: Remove optional 'size' arguments from strscpy() calls

The 'size' parameter is optional and strscpy() automatically determines
the length of the destination buffer using sizeof() if the argument is
omitted. This makes the explicit sizeof() calls unnecessary.

Furthermore, KSYM_NAME_LEN is equal to sizeof(name) and can also be
removed. Remove them to shorten and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250310192336.442994-1-thorsten.blum@linux.dev
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f159dba..e7d0b05 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8665,7 +8665,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	unsigned int size;
 
 	memset(comm, 0, sizeof(comm));
-	strscpy(comm, comm_event->task->comm, sizeof(comm));
+	strscpy(comm, comm_event->task->comm);
 	size = ALIGN(strlen(comm)+1, sizeof(u64));
 
 	comm_event->comm = comm;
@@ -9109,7 +9109,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	}
 
 cpy_name:
-	strscpy(tmp, name, sizeof(tmp));
+	strscpy(tmp, name);
 	name = tmp;
 got_name:
 	/*
@@ -9533,7 +9533,7 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
 	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
 		goto err;
 
-	strscpy(name, sym, KSYM_NAME_LEN);
+	strscpy(name, sym);
 	name_len = strlen(name) + 1;
 	while (!IS_ALIGNED(name_len, sizeof(u64)))
 		name[name_len++] = '\0';

