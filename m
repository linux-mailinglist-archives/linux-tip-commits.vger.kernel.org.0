Return-Path: <linux-tip-commits+bounces-6278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE8CB29F10
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40575E27F9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC331815D;
	Mon, 18 Aug 2025 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pdVLiPYK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EjYsWxoW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D335310781;
	Mon, 18 Aug 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512609; cv=none; b=E22r6j7flfUpd2EtgZm2K5YUiK2E7HD3EG7JKwsuEORtULh9Mc26UQfac2c2JpNTZA5MP/NyQtz6NEQGoMWHrfRrwvbYP5MqRkJWSlnSTRMTmDYpdQmDtN76k8yFziP4l/f7ecYOHECzRXIS9OPqeNYqx+Cz2QAjienaU49hsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512609; c=relaxed/simple;
	bh=GE/u8dYTl8VHwlMfJFfQXfLtXYRqYyZ/CY124QuwrYg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mmT0o1ywFSKvFRnKn9SpxRl9r8Z6oAnFnRXnmdUWqbFhHZ5C3i4SWKhqNYg5Fdrv5DhH/sh7OkMs0qkRqEIWprg8ROe+GeTQ+OsAoyosbbQevm/hIgaafAUhN0WDh4T63IuP1R+eH5oqKZZyUtlYfaypEga9DjWOsq0q48Mz4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pdVLiPYK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EjYsWxoW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:23:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3Md/AQhG1ZLlBTaFFMWSd8m5xbLHTdQcs3pXqPBy1o=;
	b=pdVLiPYKhUJ5D2Kmz+NqHTI5rkAWx1PRkM8+Ka8E1gUnW+NX4XQq3jek4wN/RsmXNMcFza
	7anzLy9wnvxDaelTAgARACtCY3UcdxGZNj037mdHkUYT4smirrHY2LLn/WpTiQ03kbfKMx
	TQ3UTNHAnwFVR+Bww1r9FcqJMS7JRKOGF7/cT65s5Uwh63flWmgxKcG0VmeSrE4sIUPjpB
	zwq5H0fPl9nZ8AqBdteTI3srN4iFETmOwezoZj+l25zr4zlShIHR+ZVG4FTPTMhUcfn6Wg
	tx1uyw6EXglrjOrRPF4NaVtFcDszJoQajnNCNqW0Gc3F9pJiPCBdw+tQUYOfhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3Md/AQhG1ZLlBTaFFMWSd8m5xbLHTdQcs3pXqPBy1o=;
	b=EjYsWxoWQSDJJu4E2CpgDVmssR6iU7t2IuquxTju1x+x1vdp3BMME5eGzOq7y/rwKDmhgv
	kPYtpW536hWf1uBw==
From: "tip-bot2 for Yunseong Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Avoid undefined behavior from
 stopping/starting inactive events
Cc: Yunseong Kim <ysk@kzalloc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812181046.292382-2-ysk@kzalloc.com>
References: <20250812181046.292382-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551260461.1420.5230469956428038233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b64fdd422a85025b5e91ead794db9d3ef970e369
Gitweb:        https://git.kernel.org/tip/b64fdd422a85025b5e91ead794db9d3ef97=
0e369
Author:        Yunseong Kim <ysk@kzalloc.com>
AuthorDate:    Tue, 12 Aug 2025 18:10:47=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:12:56 +02:00

perf: Avoid undefined behavior from stopping/starting inactive events

Calling pmu->start()/stop() on perf events in PERF_EVENT_STATE_OFF can
leave event->hw.idx at -1. When PMU drivers later attempt to use this
negative index as a shift exponent in bitwise operations, it leads to UBSAN
shift-out-of-bounds reports.

The issue is a logical flaw in how event groups handle throttling when some
members are intentionally disabled. Based on the analysis and the
reproducer provided by Mark Rutland (this issue on both arm64 and x86-64).

The scenario unfolds as follows:

 1. A group leader event is configured with a very aggressive sampling
    period (e.g., sample_period =3D 1). This causes frequent interrupts and
    triggers the throttling mechanism.
 2. A child event in the same group is created in a disabled state
    (.disabled =3D 1). This event remains in PERF_EVENT_STATE_OFF.
    Since it hasn't been scheduled onto the PMU, its event->hw.idx remains
    initialized at -1.
 3. When throttling occurs, perf_event_throttle_group() and later
    perf_event_unthrottle_group() iterate through all siblings, including
    the disabled child event.
 4. perf_event_throttle()/unthrottle() are called on this inactive child
    event, which then call event->pmu->start()/stop().
 5. The PMU driver receives the event with hw.idx =3D=3D -1 and attempts to
    use it as a shift exponent. e.g., in macros like PMCNTENSET(idx),
    leading to the UBSAN report.

The throttling mechanism attempts to start/stop events that are not
actively scheduled on the hardware.

Move the state check into perf_event_throttle()/perf_event_unthrottle() so
that inactive events are skipped entirely. This ensures only active events
with a valid hw.idx are processed, preventing undefined behavior and
silencing UBSAN warnings. The corrected check ensures true before
proceeding with PMU operations.

The problem can be reproduced with the syzkaller reproducer:

Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20250812181046.292382-2-ysk@kzalloc.com
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8060c28..872122e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2665,6 +2665,9 @@ static void perf_log_itrace_start(struct perf_event *ev=
ent);
=20
 static void perf_event_unthrottle(struct perf_event *event, bool start)
 {
+	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
+		return;
+
 	event->hw.interrupts =3D 0;
 	if (start)
 		event->pmu->start(event, 0);
@@ -2674,6 +2677,9 @@ static void perf_event_unthrottle(struct perf_event *ev=
ent, bool start)
=20
 static void perf_event_throttle(struct perf_event *event)
 {
+	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
+		return;
+
 	event->hw.interrupts =3D MAX_INTERRUPTS;
 	event->pmu->stop(event, 0);
 	if (event =3D=3D event->group_leader)

