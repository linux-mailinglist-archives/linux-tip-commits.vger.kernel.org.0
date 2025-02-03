Return-Path: <linux-tip-commits+bounces-3318-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85622A25A18
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BA73A264A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F1B205ACE;
	Mon,  3 Feb 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MGq6/kub";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBlhFbJ5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEA205512;
	Mon,  3 Feb 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587007; cv=none; b=AVr2Vj38ZlxXyFV/M/14P6ezotpQwIUc/52QrOdERmAWeWXGdnBGqnr7tKDR0/XNBVYiGJ+nBHhMBY6Pf3OBS13LANxqi5VKW6cUG7NzZTTyqhmVBeNV/UeYwsxCy7WGC26aP7ExacmU63kIa8MXM9GMqYDlIMwCRQCu9Oi3eX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587007; c=relaxed/simple;
	bh=qTxAbIS9EYM4HupurVRMqWGD49IgW1rlvsmRwnq4RpM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qVUg4Ekh+dkloc+OwGXy/XZtqut8zF5e2MxCJozbZOi5WFhc9NFqSSvZ6P1Ut+KWGQa7bmo2VUA3aLxNJS3XCRnwcpuQAfgMDjfpsLZWEe1KZgNwhH4PSva7MpYZOrof8ywOIWiov2a0UIGc4aWan/bM4EKDbxXtOi2RZPZe9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MGq6/kub; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBlhFbJ5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:50:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738587003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqXrFjKeaB2WgOBwlrFJlEvqgyfwSfeyQEFWdrtrAes=;
	b=MGq6/kubojD0iBh5Aw6bBohHTs42+QuCfh7eYIHCpQUPzeTd/nzLPvM291/vSKugyprKsT
	VBuwvKDI3XsncCxMGNmqjJL59Qm6MCtlfGAQ/IwE3vlJJUmEtPpxFg3pVWfMCg4a8OjDz7
	aB1M3wUz8vgrVNmy7iv+H0coYSlcCyJj+SCgcJ3Ajjb94SsGsLFF5PLQjgm1JrJlN1pdch
	GriN+hLbxlMVFQI9rH547eyFu5Q4+Kxnoma1i9nJh2qdzNLTIuIyheFWNChqPsGltWr33s
	npC2IQE2I9E9ve/KmxdW+2LFjgrPusukNcfdbqYYOy4c/7/w3Ah9vRONOVg1ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738587003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqXrFjKeaB2WgOBwlrFJlEvqgyfwSfeyQEFWdrtrAes=;
	b=xBlhFbJ5P1kPYXk1bOILV+SaKDHBBq1ckKiihapvwpqi84QtoA3auSnp7y+8AMPcUQV+RQ
	ythD5smP9C2Ua3DQ==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] module: drop unused module_writable_address()
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250126074733.1384926-9-rppt@kernel.org>
References: <20250126074733.1384926-9-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858700317.10177.16476326664244943525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     602df3712979de594d268e8cbca46a93126c977d
Gitweb:        https://git.kernel.org/tip/602df3712979de594d268e8cbca46a93126c977d
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Sun, 26 Jan 2025 09:47:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:03 +01:00

module: drop unused module_writable_address()

module_writable_address() is unused and can be removed.

Signed-off-by: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250126074733.1384926-9-rppt@kernel.org
---
 include/linux/module.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ddf27ed..a76928c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -768,11 +768,6 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void set_module_sig_enforced(void);
 
-static inline void *module_writable_address(struct module *mod, void *loc)
-{
-	return loc;
-}
-
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -880,11 +875,6 @@ static inline bool module_is_coming(struct module *mod)
 {
 	return false;
 }
-
-static inline void *module_writable_address(struct module *mod, void *loc)
-{
-	return loc;
-}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS

