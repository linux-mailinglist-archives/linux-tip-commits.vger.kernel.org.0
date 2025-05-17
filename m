Return-Path: <linux-tip-commits+bounces-5646-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954EDABA954
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C3A023EB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAB81FFC6D;
	Sat, 17 May 2025 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ljn2PJ0Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZyPnu7L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFC1FDE09;
	Sat, 17 May 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476181; cv=none; b=TBT/R/dDas56mZaY1rrHwZIB6wIwMurMBydrzEGOi+4LQEkl/ELuJR9WeMl5P27jRqOtH4mR3j9KQWuvVul3rPM7eR4+9NYDqb4av/exVHkRsqR6hi00UCA2VKl/Mtpkn1/M0CpQ6xH4ujSNOQyaHWP04QeiC1JV7mCDorp143o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476181; c=relaxed/simple;
	bh=b+FnGGrNoQVoCzD53W4KbMFgDu4nwfjrZhbLuNaLrl4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ivi6okpwggmDKwCrp3ulmsxb3xuvGcpOjjfw2UTuVqTw+eUSzd2cMKL/IKN9zuNxFvuWxTDjjBdH/q63fbkLgFdD23agkb1eQSpsd/mg3i7GhQK1mBY+ae/yt40l+aOwg98l6fOvEMXJhtCIgw0XW7BfUHXEFAs4gqwENWw1tTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ljn2PJ0Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZyPnu7L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FiIVreNnll0P3VsUmVfTsrVOBAoN/MWXEnyzjFLYBpw=;
	b=ljn2PJ0Z5girt/2xTG/AdNauOlWq6TwazuYDGmjvbhkNblipjltfnmGkoFXLa8MVQzHJ0t
	Ap0jYtKi/gQb6nW7yTE7caq2fWNWIM7oL8GZ1xp3HOGMa1/veBcrLPjdRY3Bf0jjZG6iQT
	Owhxg6lVcDqn1FVRl0IIxXo6HimVo2Xy7OnuDG1w7yi2JRo+loN2pkVgZ8ZHe0xcmYchcv
	r2CXDxmJKC65i9O0EO3HGmYhLg/Bo3ePBdijX6na5DzeREMFijNYXZsS0mNmSphiwtLiMB
	Ln7IZdXOTAwMi2Af27N7OMr8AMZShGJduY5aJ/WUgEGAWnjbcTPz1KRn4BGULw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FiIVreNnll0P3VsUmVfTsrVOBAoN/MWXEnyzjFLYBpw=;
	b=UZyPnu7LWlTDo5KMX7kQl9fjM/sj2fktDwhhkW+J/P2ClMaA5Y7eNZYkOx+4KzlW3+vfEz
	S2c64jMNpyHTACDA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add 'resctrl' to the title of the
 resctrl documentation
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Fenghua Yu <fenghuay@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-15-james.morse@arm.com>
References: <20250515165855.31452-15-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747617686.406.9029125787763960693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     003e86077143ebeaa5299fb2bc907ae3b6650028
Gitweb:        https://git.kernel.org/tip/003e86077143ebeaa5299fb2bc907ae3b6650028
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:44 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 10:53:45 +02:00

x86/resctrl: Add 'resctrl' to the title of the resctrl documentation

The resctrl documentation is titled "User Interface for Resource Control
feature".

Once the documentation follows the code in a move to the filesystem, this
appears in the list of filesystems, but doesn't contain the name of the
filesystem, making it hard to find.

Add 'resctrl' to the title.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-15-james.morse@arm.com
---
 Documentation/arch/x86/resctrl.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 6768fc1..c7949dd 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: <isonum.txt>
 
-===========================================
-User Interface for Resource Control feature
-===========================================
+=====================================================
+User Interface for Resource Control feature (resctrl)
+=====================================================
 
 :Copyright: |copy| 2016 Intel Corporation
 :Authors: - Fenghua Yu <fenghua.yu@intel.com>

