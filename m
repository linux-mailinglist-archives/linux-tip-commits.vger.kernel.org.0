Return-Path: <linux-tip-commits+bounces-7295-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA4FC4D751
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73C974FB64C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE965359713;
	Tue, 11 Nov 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b566P3co";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6A7R9uQK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE0256C8D;
	Tue, 11 Nov 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861035; cv=none; b=QfPZeQXrGdFU855daVM1PdiywyzIz6RWK/kQ+E8eqB49p4Bw/9ANCexjBjL6UaS6FgjT58vjo9dxkgLkRWRPQvuX225NGMmbp9Cyfj6adNlEfjD+uuLwdbfV2j3ES0mr93ovxoFg4eBAxfHjdgdZBnz6XB6D3lUQ7xR0j6ljflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861035; c=relaxed/simple;
	bh=GWfUzrnlQN8MU3MsDAzlJhWkBP5KxM3HzUpPwxuZILk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qb2NjKCovH12VwQfEB+iAH+PKMzRDjlmBYoW031tT7WQfCuVNnrHMxTV39L1s1oyVgNoWKA8aZilX63qKbirmowgz+J/m6vRlircCydD9AbQkNGv9eezrBdCvCAu3iDJRl4ldzwcHN9E/TDeFpbKZ+2FcPfyqUomJX7jg+fUAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b566P3co; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6A7R9uQK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e8ZEyWW8ONAPtXacQEaf1DoQqxHSCk4LwHCas44Z2w=;
	b=b566P3coqt2wddw9juWYQGucKCiC3y1xbNRKQhuP5gCuTlI3joT4wnHM31nroKKnpn4sAk
	fAYqxzXiSf/R8ic3HBU09vIXTqkQDq9pDbWY3+O2XgdKu2+i0cmDwOpjWwNGgB4wgF8hIZ
	sV/VzKfHkHIJaND/oRMOCpAEbtYJbm0oDJlWbKdmgg5jHpB/HuCavWspme9wgimbP+1AB9
	jhkkOts2NeF54K98EzUS5ojtCIpWBC9Z0FZSn6t7eKzuBHehNwydlQC3btrPFKECbe86rH
	MWBT7vWgYzWEiTB7SckC1bVj7zTJ/QAGmmCwfY6G4xGNI7+jdlyMYk/UpY1WVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e8ZEyWW8ONAPtXacQEaf1DoQqxHSCk4LwHCas44Z2w=;
	b=6A7R9uQKbqgvbxIvf5QGNsOpQ464WNaUUx/IOjmskhIYucO5KTV0j2nyktBjhF5xuvKRcP
	7tCAE3rgqnM9T1BQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Remove redundant is_x86_event() prototype
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-2-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286103089.498.17046501566571354111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c7f69dc073e51f1c448713320ccd2e2be63fb1f6
Gitweb:        https://git.kernel.org/tip/c7f69dc073e51f1c448713320ccd2e2be63=
fb1f6
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:25 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:19 +01:00

perf/x86: Remove redundant is_x86_event() prototype

2 is_x86_event() prototypes are defined in perf_event.h. Remove the
redundant one.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-2-dapeng1.mi@linux.intel.=
com
---
 arch/x86/events/perf_event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2b96938..285779c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1124,7 +1124,6 @@ static struct perf_pmu_format_hybrid_attr format_attr_h=
ybrid_##_name =3D {\
 	.pmu_type	=3D _pmu,						\
 }
=20
-int is_x86_event(struct perf_event *event);
 struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
=20

