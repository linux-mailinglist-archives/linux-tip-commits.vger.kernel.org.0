Return-Path: <linux-tip-commits+bounces-5828-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F134CAD8574
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B491F167A70
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C205279DA4;
	Fri, 13 Jun 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fj18iRQw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dxozeHZc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6112727FB;
	Fri, 13 Jun 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803112; cv=none; b=lsZZrHkM5lXuodj9Q9vPf9M3e7od2+uy4oRNdKzM5145r34x1XhhEBDA0VCGMPByiR8zA1phT856mAe9coKPXINCcagspJ3fdJIeKRefSrHuAaqTFXlO5gGJEDs7KZt2PgeZP73eAbcTkOiOIOAaXGskfeuhh3r1OrRvXvCyYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803112; c=relaxed/simple;
	bh=azY3xTQMc+N/iUldb5OOAmOttv3wywKDvXarvuSx+rY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hASj1DGdbEz0MSQmTg4PIjBBs+35pJi7/HXOqfTf3etnFFxX4E4pTjIXgGB7IPD0nRJDysOzAGTcfitO8GZo5uMUCiTD81bY/mYLvUtA3xY40fo7OYFb5rJGmUK2xVywm3bTBJCqHZGI+SWh5gqIbdHE6Fr+VDWIApHAKiDmm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fj18iRQw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dxozeHZc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIcfINSyO35RRPIwDHNb3xAxs8G2eApDZDCYxSN/z6w=;
	b=fj18iRQw7IpvDKCal1wJ58nDcXi9T5yfu5Y/XzmbCz7cv0b2Bfq/5/pbLd66JDIiJcl7lk
	1ggt0SSdsbhoLeryDy7eK2CfoDhBS7eUGWBO8WMKiRKbP1EpkdYFQVC+Tbo5vSjfQKEMAE
	sfcIjuOpwUCKBQgBBBreROb/bxvyL+tnLkQGRLfUlYfyK5MNWXWZvf+yf5oeQyLlvhzM/C
	6RHYt2Ht0oRAxzeitor0tSZRrK6TTF+elwBvp6xqApW8EOgOVgHbDQcLZuBPYiLl+RB2oK
	TjZ63XZTsBVgNpj+5OEqL2OsuqM3VyfD0mTSWDjmih2EwkobMUrWKdanEP3cXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIcfINSyO35RRPIwDHNb3xAxs8G2eApDZDCYxSN/z6w=;
	b=dxozeHZcpYiTTDTXKppbUop1XNOd77ApZsiqDZ4mTgnbn+A9WRFqF4lapZlaO2n0vDcau6
	PQm4v8qVJNBmd0BQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/kconfig] x86/kconfig/64: Enable BPF support in the defconfig
Cc: Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-9-mingo@kernel.org>
References: <20250515132719.31868-9-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980310871.406.14472291067184512194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     1093fbcf57ad1a95132944ff5a70d537ad2c8964
Gitweb:        https://git.kernel.org/tip/1093fbcf57ad1a95132944ff5a70d537ad2=
c8964
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:02:58 +02:00

x86/kconfig/64: Enable BPF support in the defconfig

Since the x86 defconfig aims to be a distro kernel work-alike with
fewer drivers and a shorter build time, enable BPF support, which
is enabled in all major Linux distributions.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250515132719.31868-9-mingo@kernel.org
---
 arch/x86/configs/x86_64_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index df786b8..a32ed37 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -4,6 +4,12 @@ CONFIG_POSIX_MQUEUE=3Dy
 CONFIG_AUDIT=3Dy
 CONFIG_NO_HZ=3Dy
 CONFIG_HIGH_RES_TIMERS=3Dy
+CONFIG_BPF_SYSCALL=3Dy
+CONFIG_BPF_JIT=3Dy
+CONFIG_BPF_JIT_ALWAYS_ON=3Dy
+CONFIG_BPF_PRELOAD=3Dy
+CONFIG_BPF_PRELOAD_UMD=3Dy
+CONFIG_BPF_LSM=3Dy
 CONFIG_PREEMPT_VOLUNTARY=3Dy
 CONFIG_BSD_PROCESS_ACCT=3Dy
 CONFIG_TASKSTATS=3Dy
@@ -22,6 +28,7 @@ CONFIG_CPUSETS=3Dy
 CONFIG_CGROUP_DEVICE=3Dy
 CONFIG_CGROUP_CPUACCT=3Dy
 CONFIG_CGROUP_PERF=3Dy
+CONFIG_CGROUP_BPF=3Dy
 CONFIG_CGROUP_MISC=3Dy
 CONFIG_CGROUP_DEBUG=3Dy
 CONFIG_BLK_DEV_INITRD=3Dy

