Return-Path: <linux-tip-commits+bounces-6495-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDB2B463A7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 21:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E078BA66CAB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C5427B337;
	Fri,  5 Sep 2025 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4ByeZvB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cHvq/dH7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEF271468;
	Fri,  5 Sep 2025 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100791; cv=none; b=L9OBPnV9kIeIizPVw/L1g+N/nB2C4HdYSDo1dtktV4xhk+BSyvJ2zxdpXhh9ItwzG0/PSS+th2KjM/CwaBjdFadP9q76e3Bg8E1bbLrZbJ8lYBEaRbfhWYgUaP3qYcw6uVXG+HSrxzRdCSnYm40uLQYu8ubCcNu0meG+JbeDtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100791; c=relaxed/simple;
	bh=RdwF8RYvfBziCGHu+3tSEz7PQxlFcHuAaDTsxYGwn3g=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Qp9ra2cRJQdShJpNkuT2TrPH29uYSlks+GXip81r6AZWXKxLcDp2NZyfSeqZJEIUUEVoWprCFgBq5c4Qg9inacjgdfd6gDIV1Zt6lo7LORB0ZOa37eyb8VFR8FOf3K03rRz9OOreqzcJkR0770hYdBqN9EGTMjBzh5rRsXxZhnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4ByeZvB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cHvq/dH7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 19:33:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757100787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=u74SaOyOielbCgmSsfKFdXctOlYey7Pz58zAJg8OeP4=;
	b=U4ByeZvB9RGle2/unz6hTpZ9nTZkgSn2NGH8+t9I8F9ACYJ+TUPY8FRp4EpT89G+Kz5nu8
	XmEUhFtzdye9+58d89xm2d+BPr/8wYUmnaUUDfamW070jf9sEAwhNos713Nx1gtuvDuEgO
	TbfvhcK27+Q2TVuGC4z3F6DTPRXGpFzfEJq7d0CY7VACgNnxvC38CcF5Aa6oQL5lYR9jjt
	fTEZRjQkxcevM2ykzh5iHUpWfsCSaeOLEMeMlV0Bgi4S+6DgVuXv0f7L16WEG8w9gtVUwO
	vglzhzF6cUvQXXk1m94J/llnDOOKP110E7JuGkuJvNqd2N7whoy35EfZp5oWIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757100787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=u74SaOyOielbCgmSsfKFdXctOlYey7Pz58zAJg8OeP4=;
	b=cHvq/dH7x0hfOuuHwrqffNUKgAg+E7YAHbcdhhSRKoq/eSFY3YwnRMnbw4jGbDDeLhE4qV
	PSegth5psc4Q35CA==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Update the kexec section in the TDX
 documentation
Cc: Kai Huang <kai.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175710078604.1920.10357153092237444664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     5f9b5bd0c82925e4a71c5790a37b3142fec946d4
Gitweb:        https://git.kernel.org/tip/5f9b5bd0c82925e4a71c5790a37b3142fec=
946d4
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Mon, 01 Sep 2025 18:09:29 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 05 Sep 2025 10:40:40 -07:00

x86/virt/tdx: Update the kexec section in the TDX documentation

TDX host kernel now supports kexec/kdump.  Update the documentation to
reflect that.

Opportunistically, remove the parentheses in "Kexec()" and move this
section under the "Erratum" section because the updated "Kexec" section
now refers to that erratum.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://lore.kernel.org/all/20250901160930.1785244-7-pbonzini%40redhat.=
com
---
 Documentation/arch/x86/tdx.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index 719043c..61670e7 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -142,13 +142,6 @@ but depends on the BIOS to behave correctly.
 Note TDX works with CPU logical online/offline, thus the kernel still
 allows to offline logical CPU and online it again.
=20
-Kexec()
-~~~~~~~
-
-TDX host support currently lacks the ability to handle kexec.  For
-simplicity only one of them can be enabled in the Kconfig.  This will be
-fixed in the future.
-
 Erratum
 ~~~~~~~
=20
@@ -171,6 +164,13 @@ If the platform has such erratum, the kernel prints addi=
tional message in
 machine check handler to tell user the machine check may be caused by
 kernel bug on TDX private memory.
=20
+Kexec
+~~~~~~~
+
+Currently kexec doesn't work on the TDX platforms with the aforementioned
+erratum.  It fails when loading the kexec kernel image.  Otherwise it
+works normally.
+
 Interaction vs S3 and deeper states
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20

