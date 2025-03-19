Return-Path: <linux-tip-commits+bounces-4337-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C16A68AA2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E125E19C29F1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D742561A4;
	Wed, 19 Mar 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKoXDmni";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OVm4IELg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65525525D;
	Wed, 19 Mar 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382218; cv=none; b=lFX/6ehQHezSBEMvoWdsRYJgrg7ZXC5VG3dguMRNIbncEDgPMXFeJI9GyX7fPW18K+R2dAF3njJEhBMoRnzwoF8Evy7/qRxyQ9EaPrVo157C7hik+UU+QfvSW3/NilzIrAyr/Ltx9S7O+O9z/pcRg4kyqPudwAD2eNY9qNbyc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382218; c=relaxed/simple;
	bh=lKUf/h1VI2diDMSKRn5tNfzE9XWMaQ+GwoKqkPkh6e8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rkCR6S6X/IMj6DWObpYG6/C3agwLOQ1C9RUhinoNupVcYhf69PjAnSd5NnbmMBgIJY7f/5t7c+aULBLmqZqxud9Ct76ztE+J9ZJQ1zBhjIrDeMpas+MRU6GWJ6H/cmW1MhYG5CeYUYBEGITl0a6R9OpbG4EYOiYMiXA4jCCzblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKoXDmni; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OVm4IELg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8fvicAPx4Fjx3mEITneEdKlHOqTmXEGQAk7KfajmHo=;
	b=pKoXDmniczTPtjrEG1ROIgr+BXaa5RGml5srvw9oU4ibfCQORgqgOwSOpX8shLZARYA+d5
	U/AczQ0Wiu5DkNRISN9ZsiTYyDFGcT/FbvkXjd/6XNgnyKn3zhC22flDx+KSSjbhwp7ECv
	vT45YUtXtXXu8cXJkOfESMntvoDs6GHaLuhjdZkmElZWsAutvNkFu1tz105rKMsqd6zBSl
	0s7GNjRPSRlGEylETmFN2kO8Lw7VbMHfvhPrOZD7VheKDrwC8ZmjsLQ573Bgmlhknr0ZIM
	R1F6MWg72oj6yyXu4pCjhQUm045F0tVXsJq0pa6pvvHZoaAleb3CTRPuZn2Tcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8fvicAPx4Fjx3mEITneEdKlHOqTmXEGQAk7KfajmHo=;
	b=OVm4IELgpaHayGPWd9yyTvVT8EKcPcUdzHcw7bcGSJtXtTpUT4WpwMRDKleMJe0Q4wgLOg
	QVT7PZSBcPoIiBBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/stackprotector/64: Only export
 __ref_stack_chk_guard on CONFIG_SMP
Cc: Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-8-brgerst@gmail.com>
References: <20250123190747.745588-8-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221499.14745.17308702689554900125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     91d5451d97ce35cbd510277fa3b7abf9caa4e34d
Gitweb:        https://git.kernel.org/tip/91d5451d97ce35cbd510277fa3b7abf9caa=
4e34d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 12 Mar 2025 12:48:49 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:26:58 +01:00

x86/stackprotector/64: Only export __ref_stack_chk_guard on CONFIG_SMP

The __ref_stack_chk_guard symbol doesn't exist on UP:

  <stdin>:4:15: error: =E2=80=98__ref_stack_chk_guard=E2=80=99 undeclared her=
e (not in a function)

Fix the #ifdef around the entry.S export.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250123190747.745588-8-brgerst@gmail.com
---
 arch/x86/entry/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 088f91f..d3caa31 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -64,6 +64,6 @@ THUNK warn_thunk_thunk, __warn_thunk
  * entirely in the C code, and use an alias emitted by the linker script
  * instead.
  */
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && defined(CONFIG_SMP)
 EXPORT_SYMBOL(__ref_stack_chk_guard);
 #endif

