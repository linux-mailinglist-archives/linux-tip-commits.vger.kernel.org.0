Return-Path: <linux-tip-commits+bounces-1576-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213792482E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CBB1C2527E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6FE1D362A;
	Tue,  2 Jul 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMY1gvID";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJRJTTSY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A21CF3F5;
	Tue,  2 Jul 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948259; cv=none; b=AOxwRhdyy4lSoGzhkjleBLOERWAa0BXrGqJiBv/e+Ts2JHNDU7ycPPytok2e0hoWt7fS/E5emV4p3k3P9KT3/EmgBDYj4usCyrUFp2aWa36KtxLSoVbIY73Ia2j/pZOeqWPiYYXIvp6/Ktnr7zfp/UZehzcSkBP8n6BQ4jwNeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948259; c=relaxed/simple;
	bh=ltmsxGan0AKeufTqsniTpSl8uxfsqjsgxh5ymwJ2Mb4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vav+MlVdjbnPITbRVvDEWhUcifyc/4PYXCPx+xkYrtNVrhXN6Q/CULWgL4uvqFz/idZ9GYs3INavUGHnyvHH6DgO4iz9f2q4jyOjxpc2N/aS9Vhz+kUdKO3Uk+/l5wUl8kC7jRw9X1LEGSHj2fM7qhbCptGqTf7pULNcMMIgZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMY1gvID; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJRJTTSY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypaK9dCgvNTeVmQugIHrprozVZPGSqTPspKWsHIP0y8=;
	b=DMY1gvIDqLuc8ABn4W//K7leOi6jUOymmuMGjydl8sOVS2tJNd7oDyUIU9m+oafdSbIL65
	qVKtc/EMnMAVEi3T9fNuXvaT+gMywvG7pVJsWlyWmvSKMMelEsW8fHuvzRN8U8tpuMxqRb
	G6SbOqUY+Xl2yBODDPwxNLZnOwnytLnWOQjsF+6zjf0dj8m2EXCzsmenjqSSXfrnM3usdA
	Jq2ex1uWg9wywcCLuzxImXwH3f4udYVE1vZMDD/HSV8D602SxMNZsyHAXYd+k0gfoA8Cm5
	F0iHTSNiB60xVIqZLL/2DCIQDzMljsTYDobtE7GhCqzV6B1yt9fuGTNsLgAqAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypaK9dCgvNTeVmQugIHrprozVZPGSqTPspKWsHIP0y8=;
	b=pJRJTTSY4qUppm16aN+wHCZBCXcc0jIxs464u043FVpf3hDhAAwM1BwfHmNSOcb4DywldX
	sDfL6TJHJjQjdRBA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add node-scope to the options for feature scope
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-6-tony.luck@intel.com>
References: <20240628215619.76401-6-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825593.2215.1776037474900122102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     1a171608ee8d40d22d604303e42f033c69151123
Gitweb:        https://git.kernel.org/tip/1a171608ee8d40d22d604303e42f033c69151123
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:05 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Add node-scope to the options for feature scope

Currently supported resctrl features are all domain scoped the same as the
scope of the L2 or L3 caches.

Add RESCTRL_L3_NODE as a new option for features that are scoped at the
same granularity as NUMA nodes. This is needed for Intel's Sub-NUMA
Cluster (SNC) feature where monitoring features are divided between
nodes that share an L3 cache.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-6-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 2 ++
 include/linux/resctrl.h            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b4f2be7..b86c525 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -510,6 +510,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 	case RESCTRL_L2_CACHE:
 	case RESCTRL_L3_CACHE:
 		return get_cpu_cacheinfo_id(cpu, scope);
+	case RESCTRL_L3_NODE:
+		return cpu_to_node(cpu);
 	default:
 		break;
 	}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index aa2c22a..64b6ad1 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -176,6 +176,7 @@ struct resctrl_schema;
 enum resctrl_scope {
 	RESCTRL_L2_CACHE = 2,
 	RESCTRL_L3_CACHE = 3,
+	RESCTRL_L3_NODE,
 };
 
 /**

