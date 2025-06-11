Return-Path: <linux-tip-commits+bounces-5775-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBAAD5A94
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 17:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFE03A2AB3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2BE1A8404;
	Wed, 11 Jun 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2j70mlO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1xQhcw20"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A21DD543;
	Wed, 11 Jun 2025 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656056; cv=none; b=sh8u+il8rdJtZqZ6Kdu4yLNOF8FGXSNswPlwdk7DI+i8Idml3v2g83lhxxIRC5lXdNri7zENHGI2p3bs8p3e5lMB5sHildO7CewOWvfJy1T4ILlAuTKwzlih+2Bd0LBtewpLFsEJ+AmTk+K6qkQ2kFY8sq4x/duDijt8ztA0MHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656056; c=relaxed/simple;
	bh=9Cn8xCJnMrdyjIC7GBclUP/oF9++n4Rk30Nc++P2pk4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=k8Chf8XV0HK7Xu1E9I+4CtMTJa7LowqCNormz8I0HGpVZZfsTBMwpdZmqm8X7KK1VvOHncV3pEebi9kRFY7AAEJZJ3JzXitMaVBL3r/Fof+LAT43we62GkF7+2m2/3IkJ8NDZHA3VOFWbSVnd++8/E48BuVkfaC8KPCXNEt35pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2j70mlO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1xQhcw20; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 15:34:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749656052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MHaXFlMPqO8QzS0ubZnQNxZbKeIijGlQp4mt3mEZOcQ=;
	b=L2j70mlOD23qRVQaQBA9hq4pJH+NU0faVO89jLVwUp19R0P2yDkfXjvpkXLzePseuylPqN
	MY2+6EGIJStYU1xh+gl/frAagmKAJUJvYX6fRKg+eWPqisac1kwn6Rvdr8fjaUuqYOlJML
	5VeSF/LXh8DPiSddjHA6BrKURaEVwlVFfos6xFmd+ddnqgF2iHJbkrLhVE62yICR50Gb7g
	+kD5Sqbmx3J0qeZvfoAA4ftCfFLz/XqJPRz6buuLC9KcduQoylH9FS9MpwQPvkb6kzcdJB
	wqAOoeNykr76VB2Paevy/zxdjVhYGgnr1TGej45oVRoif3mvZDkJIeRxQPI7DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749656052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MHaXFlMPqO8QzS0ubZnQNxZbKeIijGlQp4mt3mEZOcQ=;
	b=1xQhcw20ReYcm7p8lzD6vaHhtGMPU7njquIWbMcr5loJFEjO3kul6fmWprvUvJPoPFx5Cy
	O8h+2+sCv8Eh2XBw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] futex: Verify under the lock if hash can be replaced
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174965605124.406.12143206395264522390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     69a14d146f3b87819f3fb73ed5d1de3e1fa680c1
Gitweb:        https://git.kernel.org/tip/69a14d146f3b87819f3fb73ed5d1de3e1fa680c1
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 02 Jun 2025 13:00:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 17:24:09 +02:00

futex: Verify under the lock if hash can be replaced

Once the global hash is requested there is no way back to switch back to
the per-task private hash. This is checked at the begin of the function.

It is possible that two threads simultaneously request the global hash
and both pass the initial check and block later on the
mm::futex_hash_lock. In this case the first thread performs the switch
to the global hash. The second thread will also attempt to switch to the
global hash and while doing so, accessing the nonexisting slot 1 of the
struct futex_private_hash.
The same applies if the hash is made immutable: There is no reference
counting and the hash must not be replaced.

Verify under mm_struct::futex_phash that neither the global hash nor an
immutable hash in use.

Tested-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/all/aDwDw9Aygqo6oAx+@ly-workstation/
Fixes: bd54df5ea7cad ("futex: Allow to resize the private local hash")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250610104400.1077266-5-bigeasy@linutronix.de/
---
 kernel/futex/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b652d2f..90d53fb 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1629,6 +1629,16 @@ again:
 		mm->futex_phash_new = NULL;
 
 		if (fph) {
+			if (cur && (!cur->hash_mask || cur->immutable)) {
+				/*
+				 * If two threads simultaneously request the global
+				 * hash then the first one performs the switch,
+				 * the second one returns here.
+				 */
+				free = fph;
+				mm->futex_phash_new = new;
+				return -EBUSY;
+			}
 			if (cur && !new) {
 				/*
 				 * If we have an existing hash, but do not yet have

