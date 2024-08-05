Return-Path: <linux-tip-commits+bounces-1938-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C79947ABC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536061C20937
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE4F155C88;
	Mon,  5 Aug 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ac5GJ4uX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/LTD61I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E92157478;
	Mon,  5 Aug 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858970; cv=none; b=FVdv5hiSPglH+p9z7S0Wety+2HgK1fjtRnCsu/ln6HzMNn84widsxOjzBN1MnmzS8fqP35HPY2JNM6hikgy51izBkU8na3tOuk7SjdOxqFkaGBXmIaaBO09H8HY2qM0WvNLRMQelwb3Qys3cWIkY7SKV6ItvnsyrSVRyta5YOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858970; c=relaxed/simple;
	bh=Evqb92VpEKVsW0Ssc87YnUf+f6EfOJblvHdoz4WDqXA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SdTzdvQG9USYFEscb7K1PMtYJXkH8LET79y3SRaCC5lIT9br/Og1THoK8FKPETfIeBuHrixJu3y3jAmvxoFk/dG8oZ2nw59ML7Q9J1m3t1dH6PRG7eS6TWHE1Esaur3+fOEkSTqSjiygKBmPOP1m8tc5M932lNYxZ8N8VZ7e07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ac5GJ4uX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/LTD61I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5ixQYr395hUO4HjYkbS4tyMUBlqmBqzO5p2zmH8bTo=;
	b=ac5GJ4uXs9Q7ic8Kw+7VEEP3c/89SY7JNCA6aMCucVjtlLRb2fZnoCjVkjcTSdKRoaHbT+
	+Q2yunTaFsJ0Mp4uP8e4zAHXZk73LWB4+yNOmm8SN3ETYELY8RpIIjZr102uAujdiZM20t
	whZPMRQ5y9C1lZKib/6lO+H3mpV7+csxuroN7wH3jrBh8ymCm4iNUjfeFrGugSRQ/F4Int
	7ww86zoBptoEybGYF/WbXKB/BDkH/6dbrszZz1F218sZAX8wFQeNPzawRQKEx3okmaZOGo
	pZsXx2yezdBKMtfa1aKp6nvySzES7YRTDFju1BalHtUp4nphUxDK6/o1Xa0vmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5ixQYr395hUO4HjYkbS4tyMUBlqmBqzO5p2zmH8bTo=;
	b=N/LTD61IlzMeU1/ySKUCmXhia7NfFifYGDIbz3osn1qBM+aYA90ArQHCiedbXLPwloEs5p
	VovD425c2nBcP8BA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: is_trap_at_addr: don't use get_user_pages_remote()
Cc: Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240801132714.GA8783@redhat.com>
References: <20240801132714.GA8783@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896546.2215.10122357135816753782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     300b05621a3f85621130e356ca6ae90f6a4eec0e
Gitweb:        https://git.kernel.org/tip/300b05621a3f85621130e356ca6ae90f6a4eec0e
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 01 Aug 2024 15:27:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:30 +02:00

uprobes: is_trap_at_addr: don't use get_user_pages_remote()

get_user_pages_remote() and the comment above it make no sense.

There is no task_struct passed into get_user_pages_remote() anymore, and
nowadays mm_account_fault() increments the current->min/maj_flt counters
regardless of FAULT_FLAG_REMOTE.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240801132714.GA8783@redhat.com
---
 kernel/events/uprobes.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2d1457e..698bb22 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2035,13 +2035,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (likely(result == 0))
 		goto out;
 
-	/*
-	 * The NULL 'tsk' here ensures that any faults that occur here
-	 * will not be accounted to the task.  'mm' *is* current->mm,
-	 * but we treat this as a 'remote' access since it is
-	 * essentially a kernel access to the memory.
-	 */
-	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);
+	result = get_user_pages(vaddr, 1, FOLL_FORCE, &page);
 	if (result < 0)
 		return result;
 

