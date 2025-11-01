Return-Path: <linux-tip-commits+bounces-7127-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99961C28698
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE86421CD9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D270F299A85;
	Sat,  1 Nov 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+TLdIBI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9SXRiaD5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972A291C1E;
	Sat,  1 Nov 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026088; cv=none; b=jk9iJcSqCtPsWWgpUpAIvQPsZRKbtdbHyVEikvT0qgFvAvcn9GUwy1rbYPro7tHUE6IDRSLzaWAmoCyKgZJWRsSO3Ihf4iNiydcTLWpu1+SOZgcuBTcJr9hYhlwB84wBkOUO6vH2lrf+ypcoGZbr7/1Pj3cfjNsnn1/k2KYJFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026088; c=relaxed/simple;
	bh=LnJdJBBSR8Spbl8Zg1CsMI2hwrS07ZWdeWLFyJ4YR0A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gfPkeWTTJzhj6WooCgn2B5FAsq80V9hrHtooS1FQTDmB4AO4wxbvdVGdDNrsa3/Ve0AKXqPIHI1xyJjurjJBd6cFODVWzaN2d5ZfvUGBQyjiRrr8d9yHEMTGmor7v7V4dEmQSDc0qt2ZqX2BEeFQC7s3HTYjN7YtYIn1pjqj5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+TLdIBI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9SXRiaD5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNsgzTSnsN3Zb4kj/794FlG0WALVMA4P49bIRDYp2T4=;
	b=g+TLdIBIIjv2e/LJYJE62MDfmPQXnX+RwKd1JWoBSd8XhocobqJtL2t5lukKEG1dqJlsa1
	I8oxAAXDihFcUrwQf8NWSorKXBNq/+3id71AKg6pfdDSSNO9ccZfd8W/x6hEOpZA0MAvLK
	ESNLDUh34bS094+MvFpvVCE/WTw/Mp94Z+rgxSkz85M0buHgtTwrWzU6y2ChYHJPkUPg/E
	VO9FfsfQmBXn3L41J5DSoPHh+n61ygdnCLYZGvOUyxmDxqb3p/9QzfNOyw3cxhDqoyczQu
	pEJT9YAFSHTCjFW35jpDAe3HozL5aaq4Djze/0m9oI7VaHn9854p7eshSn0ZLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNsgzTSnsN3Zb4kj/794FlG0WALVMA4P49bIRDYp2T4=;
	b=9SXRiaD5AL556yRTvdbda6DERwNA7MAkcKAgLpUK3szCnM6kXmcVjynnGd+gNuun86AOGr
	t9t0k0aI0J5IJqCA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Assert that hotplug preparing
 CPU is part of stable active hierarchy
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024132536.39841-5-frederic@kernel.org>
References: <20251024132536.39841-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202608401.2601451.14363274452117247141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3c8eb36e2a46786d50dbef417ef782ff37b372ca
Gitweb:        https://git.kernel.org/tip/3c8eb36e2a46786d50dbef417ef782ff37b=
372ca
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 24 Oct 2025 15:25:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:38:25 +01:00

timers/migration: Assert that hotplug preparing CPU is part of stable active =
hierarchy

The CPU doing the prepare work for a remote target must be online from
the tree point of view and its hierarchy must be active, otherwise
propagating its active state up to the new root branch would be either
incorrect or racy.

Assert those conditions with more sanity checks.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-5-frederic@kernel.org
---
 kernel/time/timer_migration.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 49635a2..bddd816 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1703,6 +1703,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigne=
d int node,
=20
 	if (activate) {
 		struct tmigr_walk data;
+		union tmigr_state state;
=20
 		/*
 		 * To prevent inconsistent states, active children need to be active in
@@ -1726,6 +1727,8 @@ static int tmigr_setup_groups(unsigned int cpu, unsigne=
d int node,
 		 *   the new childmask and parent to subsequent walkers through this
 		 *   @child. Therefore propagate active state unconditionally.
 		 */
+		state.state =3D atomic_read(&start->migr_state);
+		WARN_ON_ONCE(!state.active);
 		WARN_ON_ONCE(!start->parent);
 		data.childmask =3D start->groupmask;
 		__walk_groups_from(tmigr_active_up, &data, start, start->parent);
@@ -1768,6 +1771,11 @@ static int tmigr_add_cpu(unsigned int cpu)
 		 * active or not) and/or release an uninitialized childmask.
 		 */
 		WARN_ON_ONCE(cpu =3D=3D raw_smp_processor_id());
+		/*
+		 * The (likely) current CPU is expected to be online in the hierarchy,
+		 * otherwise the old root may not be active as expected.
+		 */
+		WARN_ON_ONCE(!per_cpu_ptr(&tmigr_cpu, raw_smp_processor_id())->online);
 		ret =3D tmigr_setup_groups(-1, old_root->numa_node, old_root, true);
 	}
=20

