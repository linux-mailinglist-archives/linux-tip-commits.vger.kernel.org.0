Return-Path: <linux-tip-commits+bounces-6152-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0082B0B12B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 19:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6391BAA3C21
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33DF289808;
	Sat, 19 Jul 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="scP4ENTZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QI8d59E7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099D288513;
	Sat, 19 Jul 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946823; cv=none; b=NIv1mx4I3fr3l9N62KzDNctueOw6J6+waOUcmNTWp5VDIszfJYgtpCp7A+a6MgH1AygElJQCCLrt/3XJR5i6LU79V0obTBAYFoKfCNDfrwRTZjvWtw5ARDSrMBBtJdjZnPa0sf3+A7qZe9ntlz922ViM/Ts+LwNUW9pj80qkH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946823; c=relaxed/simple;
	bh=ElOd9HLUCJm2sJ0EpsOKaMkZUlIb4gtFWtjT3XpeuQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pkAXFzvQKd+gaU3YqqU2KAz2/D4ZRYc6xAO0WY1yKOB7YYW09X44fCNqjBi/xUhTKuUitgjNVS6lDNl7KjZTCG952p950SwsRcQE5qkdcNMG8TjizsFgXrBdwSfhBlRkiy+/F6xz1G/dVe3I8hdtV1pLT7gP2NBCaj9iAIlaUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=scP4ENTZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QI8d59E7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 19 Jul 2025 17:40:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752946814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ug25qlz2yBjwOcilnNisMilLh74a7Kztg8J9q3AjgY=;
	b=scP4ENTZYBCzcDWGYKw8YauBdeOE9QYn2UZ4wB8ZYwyURB2aFvt6yq+VhoNmV4Vo1VIi3E
	iCVtljI1n5pSxfGdmW79mxN07UxL7QxDeIuUG+dMtat/OE2TLfEEAZT5x2oGc62BzGpVoB
	hu/UfpznWg1AgJnjcXydtv7Bzg/JWZbvCfM/Pl799iXmKZ+tFx6V9G/4IO/jBaRmPolw3z
	tIpWokWWsyLMHRUVH5E9WLL+UnswIUGQp8Y1DtPFsPPUStWi8L/j/OwC/nUvSuXeI7vWlq
	iQqp5T1dMaIvXax5QJr0gGRP0FaWH184qW0SfVUIJ6Q6nIJH32ZXQM0uYkyTUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752946814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ug25qlz2yBjwOcilnNisMilLh74a7Kztg8J9q3AjgY=;
	b=QI8d59E7tZzU7vusWvCGmgzRGNY4WvEd1cHu3gArXhnhh7wqnwnielzbddHmbbmgYXerFN
	iDqri/sVzXRemfDA==
From: "tip-bot2 for Jinliang Zheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Use OWNER_NONSPINNABLE directly
 instead of OWNER_SPINNABLE
Cc: Jinliang Zheng <alexjlzheng@tencent.com>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250610130158.4876-1-alexjlzheng@tencent.com>
References: <20250610130158.4876-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175294681307.1420.8503001269438279756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f84a15b90d96f3da99f67fea2e116850d99fb7c4
Gitweb:        https://git.kernel.org/tip/f84a15b90d96f3da99f67fea2e116850d99=
fb7c4
Author:        Jinliang Zheng <alexjlzheng@tencent.com>
AuthorDate:    Tue, 10 Jun 2025 21:01:58 +08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 11 Jul 2025 15:11:54 -07:00

locking/rwsem: Use OWNER_NONSPINNABLE directly instead of OWNER_SPINNABLE

After commit 7d43f1ce9dd0 ("locking/rwsem: Enable time-based spinning on
reader-owned rwsem"), OWNER_SPINNABLE contains all possible values except
OWNER_NONSPINNABLE, namely OWNER_NULL | OWNER_WRITER | OWNER_READER.

Therefore, it is better to use OWNER_NONSPINNABLE directly to determine
whether to exit optimistic spin.

And, remove useless OWNER_SPINNABLE to simplify the code.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250610130158.4876-1-alexjlzheng@tencent.com
---
 kernel/locking/rwsem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2ddb827..8572dba 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -727,8 +727,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_sema=
phore *sem)
 	return ret;
 }
=20
-#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
-
 static inline enum owner_state
 rwsem_owner_state(struct task_struct *owner, unsigned long flags)
 {
@@ -835,7 +833,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *se=
m)
 		enum owner_state owner_state;
=20
 		owner_state =3D rwsem_spin_on_owner(sem);
-		if (!(owner_state & OWNER_SPINNABLE))
+		if (owner_state =3D=3D OWNER_NONSPINNABLE)
 			break;
=20
 		/*

