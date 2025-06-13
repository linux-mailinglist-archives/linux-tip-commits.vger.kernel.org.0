Return-Path: <linux-tip-commits+bounces-5830-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C742DAD8579
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F343B70E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E799279DC4;
	Fri, 13 Jun 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDK+3Ykp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="traAt9y9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC82727F7;
	Fri, 13 Jun 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803114; cv=none; b=C9thr22kfkA0qt2U4rqLgwkhKFtAxh0qo0HTxiPVoz3YCKLS7AIVG89QtXbqq53K9nEzMPIlqjnsgyF7ZhoKbly5QrrxKn4dUxtV0gi8UrY1PoreEY7uXBSRZvpx5KRq3/HFXumT06RehSPertxI9yusfmg2MXtEeB4zWG7n0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803114; c=relaxed/simple;
	bh=IfQm2RM85NO2Rmc35YGpfrm/18e0KjzbYaKyxq8IbrY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KdDysLbCmLY59QcxrswlHVllCb1cv7OUqw+oo4wjaEagDnqespUcIsckmBBrM7muN1lzpVPnnveh+inDjfHeUC0tJN4GZR5nxsRJt6bMlf9pZJKEHztttFnLPuXJH1f2NLGdGFE9gMTa1rxt+3MMfnnHGTs2tU7KnNdD81yiUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDK+3Ykp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=traAt9y9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803108;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r635YBi/JMbSfYae1srP8gdL3+G3JkHMTcUMvWRVwZg=;
	b=iDK+3YkperJXqxbIy9DrgDJee5OX45PBBpFokM9NJwE3yYxnW5WTQmST9GdKzTkaguUUAP
	TidXnbc/6RMwL/fB7WffVtUc65q8oxVOPlqfqQHsJ9evdqnRKiiD6jFvp2FDoIiQSxA8VB
	AAIxfgt9Ng+w1ijzUntjPNHJMH5QZ80Mk9+BCGpOsOaMReH6O029bR8lMKoGS08wJT1mm3
	V4vFM29r40eCyEjeEzwQlsaiDkeSocIjtzSeayc0amCV+HVSfyLR69hpthbx+5HSN8SqR1
	uLrDXiS0M9wTinNz6ZTifdo78Lx+jc5ZhkOin2KLI+7KCCLSC5AD8Ko7L6NrEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803108;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r635YBi/JMbSfYae1srP8gdL3+G3JkHMTcUMvWRVwZg=;
	b=traAt9y96p29OANS86JjU0Lkyvc/Zg3u9MD/mZ52KresteQcXkqPcLw3tnsKTmRcMyt6fE
	0Eu37+cc9fGKnaDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/kconfig] x86/kconfig/64: Enable popular MM options in the defconfig
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-10-mingo@kernel.org>
References: <20250515132719.31868-10-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980310768.406.18345070829945395347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     4e96a8b1eb76811e75cb668a47a6642a17a239ef
Gitweb:        https://git.kernel.org/tip/4e96a8b1eb76811e75cb668a47a6642a17a=
239ef
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:03:23 +02:00

x86/kconfig/64: Enable popular MM options in the defconfig

Since the x86 defconfig aims to be a distro kernel work-alike with
fewer drivers and a shorter build time, enable the following
MM options that are typically enabled on major Linux distributions:

- ACPI_HOTPLUG_MEMORY, ZSWAP, SLAB hardening, MEMORY_HOTPLUG,
  MEMORY_HOTREMOVE, PAGE_REPORTING, KSM, higher DEFAULT_MMAP_MIN_ADDR,
  MEMORY_FAILURE, HWPOISON_INJECT, TRANSPARENT_HUGEPAGE,
  TRANSPARENT_HUGEPAGE_MADVISE, IDLE_PAGE_TRACKING, ZONE_DEVICE
  DEVICE_PRIVATE, ANON_VMA_NAME, USERFAULTFD, multi-gen LRU.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250515132719.31868-10-mingo@kernel.org
---
 arch/x86/configs/x86_64_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index a32ed37..0529678 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -57,6 +57,7 @@ CONFIG_HIBERNATION=3Dy
 CONFIG_PM_DEBUG=3Dy
 CONFIG_PM_TRACE_RTC=3Dy
 CONFIG_ACPI_DOCK=3Dy
+CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
 CONFIG_ACPI_BGRT=3Dy
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
 CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
@@ -76,7 +77,25 @@ CONFIG_BLK_CGROUP_IOLATENCY=3Dy
 CONFIG_BLK_CGROUP_IOCOST=3Dy
 CONFIG_BLK_CGROUP_IOPRIO=3Dy
 CONFIG_BINFMT_MISC=3Dy
+CONFIG_ZSWAP=3Dy
+CONFIG_SLAB_FREELIST_RANDOM=3Dy
+CONFIG_SLAB_FREELIST_HARDENED=3Dy
 # CONFIG_COMPAT_BRK is not set
+CONFIG_MEMORY_HOTPLUG=3Dy
+CONFIG_MEMORY_HOTREMOVE=3Dy
+CONFIG_KSM=3Dy
+CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
+CONFIG_MEMORY_FAILURE=3Dy
+CONFIG_HWPOISON_INJECT=3Dy
+CONFIG_TRANSPARENT_HUGEPAGE=3Dy
+CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy
+CONFIG_IDLE_PAGE_TRACKING=3Dy
+CONFIG_ZONE_DEVICE=3Dy
+CONFIG_DEVICE_PRIVATE=3Dy
+CONFIG_ANON_VMA_NAME=3Dy
+CONFIG_USERFAULTFD=3Dy
+CONFIG_LRU_GEN=3Dy
+CONFIG_LRU_GEN_ENABLED=3Dy
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_XFRM_USER=3Dy

