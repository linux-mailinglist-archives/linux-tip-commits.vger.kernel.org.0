Return-Path: <linux-tip-commits+bounces-5636-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7ADABA943
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB976A0156D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0BF1B4F09;
	Sat, 17 May 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5UOd6VM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLfFpXOw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417435979;
	Sat, 17 May 2025 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476172; cv=none; b=a1PvfjE7TvqWVudFkTyh/nBT5Yj5M1SqzH0psc/PoI+1ggy/21oHkVw0dEXBuQg/iiRev2V1IgMmAFIGK95d9agAG0yEo2yggB61C9ygGa3jyKtPdEZ8I0ZtgplhQownpxr6ZdOMh2P8PvWNvxwp7JdTrC+QQ/n1HgBal5JuBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476172; c=relaxed/simple;
	bh=foTs9X4bwwWm2KlE4A34bhobKiOFNcySlPKZWxdrKWQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zrnr6Ds0txchlsjPJTcBbJYMYvHYHeIC2sVHUyYe80pdePZMC7ZpHUBhLsVcr9kAjCzsiZ1KzaolyaZGFsEmrFG+RtOtXfDEJGWJ8/MGXyku7EcfBurj2LQv7z/taF90L7EcwsslNfNxTUpXgYHEbNRIT3OMvaHITVQinXKJkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f5UOd6VM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nLfFpXOw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJNlQZv8L8yYszKkyFzjXyoJCXnwRT6ptWjM3wsb2Tk=;
	b=f5UOd6VM+X4LI4DX558r+ZYrOQrpND5G+29gmBZ+Zk0OTb3OjwH4wRgeonMR25A1B8ZJZl
	xGHFudZOJIf7euKEJFYdKO5iCkCYuqLkWpywLd0K53BctDIO/S/II4KSAXC6K2oCJj0CWB
	5Hn4VwkII6DR6D2Mm/vBg/9kHz6qHEVB/lHAfdRN8zV4xsG9vv60RtD6/LoVv4MX/8fHOr
	9ZO0LIe18kOqtKl4ydUEAFfVClW68OAhXJ/b0NT+GWTVSWIacEhxvr5TfThiNFcTLPeoo3
	ofxJvX90HqSlrK/+cc1pTrfz1t9NP5CCs8iyQbVJo/feJ/Kyx4jcUVACbR0c5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJNlQZv8L8yYszKkyFzjXyoJCXnwRT6ptWjM3wsb2Tk=;
	b=nLfFpXOw3MnPslW4QyH5AdLUE1hmK2poY9AqFsqWeKBJQbt4tl/knIhecz+HELtxNMxlP6
	g258jDAXPq1ujZBQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] MAINTAINERS: Add reviewers for fs/resctrl
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-26-james.morse@arm.com>
References: <20250515165855.31452-26-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747616679.406.12427682987196751572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     54d14f25664bbb75c2928dd0d64a095c0f488176
Gitweb:        https://git.kernel.org/tip/54d14f25664bbb75c2928dd0d64a095c0f488176
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:55 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 14:36:42 +02:00

MAINTAINERS: Add reviewers for fs/resctrl

resctrl has existed for quite a while as a filesystem interface private to
arch/x86. To allow other architectures to support the same user interface
for similar hardware features, it has been moved to /fs/.

Add those with a vested interest in the common code as reviewers.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-26-james.morse@arm.com
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c56ab7d..d788eda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20422,6 +20422,8 @@ F:	tools/testing/selftests/net/rds/
 RDT - RESOURCE ALLOCATION
 M:	Tony Luck <tony.luck@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
+R:	Dave Martin <Dave.Martin@arm.com>
+R:	James Morse <james.morse@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/filesystems/resctrl.rst

