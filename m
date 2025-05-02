Return-Path: <linux-tip-commits+bounces-5200-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B0AA795C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B323E3B338C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 18:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B325DD09;
	Fri,  2 May 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yVuP1VVo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VjCaq9RB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D5376;
	Fri,  2 May 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746211221; cv=none; b=KbEEgShzfaUPLwX8NRzC1aW7oelfwkH6Zp6QRMiZ1oE7m3PYM62eVR4YGGLVwEnell/wFvyXrRY+cCH+OUy/4SRnJcKTw6J7ZwKnB1AIuFR4CeGbgUKn+gULzGNFXS8H/jdcqdfIEqKQnKcdtdIe7yJsPWcTFxwtbgzoazx5qEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746211221; c=relaxed/simple;
	bh=WWlvYWvX5sQaxtSf9NvaWtWy2I/qNM9Vtev3NIybXbA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=m6OQ50RLpvaeRtGvomK9tJoVH3mqeU3oXFrR20mL8lCq7UHWzR/z8CyNeJlPvfeUwqz+e4wri7N2v2Qxt4H0KQFQdsZLpFotHiPHNE4fgfzYFbMtFBgj9yGe2JtXtz8av7KMuBqZwPzSsMd5isvWHYBXK1iyjnaqb2i26biFc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yVuP1VVo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VjCaq9RB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 18:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746211210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j7SU9mYn5lZkGovlo7OmGthVh7uDHm0Iv4HEWIY1lb4=;
	b=yVuP1VVo5ZX0KUuBXKbQO0wJqVJTna67H+uh5FGXfEgSSHn0Fp5VeVyJmmu9Q9lg+Epqq2
	8IN2WGrtHYGwXeuDa6VFzaLHgdLWct39ZfCkXGPFdZZsduyvfc2FOtjA8ncIpnOIi5xKCp
	sXR7bQ6TXJBShuzLCfU8MfRINg8CpWZD9gMVKzc5I/IymKOHD7iIgJIpqFgWTulCDsw6IM
	1vE0+VXpJIKzfRkFm5eUmd4LZo+amdCPAhcEn7hynlC9FraPB12/7tJfoeV/7uj2zGgGMm
	T67diNlIWoP1zPyNC/W0R9XLV5kUEhs4/Fybm3htR1HKFoYggSrQrsR5/wDFKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746211210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j7SU9mYn5lZkGovlo7OmGthVh7uDHm0Iv4HEWIY1lb4=;
	b=VjCaq9RB7eRuX9vL2uxoFskg7an1mdY2qS5g2NLUSNt+XDVo9/WwE0c7w1zXV4UnylPBwV
	KLLVtW9989EcCaAQ==
From: "tip-bot2 for Bagas Sanjaya" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/microcode] x86/cpu: Add "Old Microcode" docs to hw-vuln toctree
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174621120116.22196.10353372719782138280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     4804f5ad5d63cf7ddad148132a3ecea11410dfa9
Gitweb:        https://git.kernel.org/tip/4804f5ad5d63cf7ddad148132a3ecea11410dfa9
Author:        Bagas Sanjaya <bagasdotme@gmail.com>
AuthorDate:    Fri, 02 May 2025 09:33:57 +07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 02 May 2025 11:33:35 -07:00

x86/cpu: Add "Old Microcode" docs to hw-vuln toctree

Sphinx reports missing toctree entry warning:

Documentation/admin-guide/hw-vuln/old_microcode.rst: WARNING: document isn't included in any toctree

Add entry for "Old Microcode" docs to fix the warning.

Fixes: 4e2c719782a847 ("x86/cpu: Help users notice when running old Intel microcode")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250502023358.14846-1-bagasdotme%40gmail.com
---
 Documentation/admin-guide/hw-vuln/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 451874b..cf15111 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -23,3 +23,4 @@ are configurable at compile, boot or run time.
    gather_data_sampling
    reg-file-data-sampling
    rsb
+   old_microcode

