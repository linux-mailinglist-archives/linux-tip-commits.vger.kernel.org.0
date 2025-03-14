Return-Path: <linux-tip-commits+bounces-4220-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD95A61C10
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7730819C79B9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF32207E19;
	Fri, 14 Mar 2025 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CZRaQm5Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8SdoCtJG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92872066DC;
	Fri, 14 Mar 2025 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982653; cv=none; b=Fc7lG7wDof09aUY6pNEVsHsxClUGqtgKNliPKA2JCweZapoY+2yGuuaZ0isiB+rHXHDF+0wvc1Qx1mVl31XsXXMpWT3PVunX1KgQzMU6LLr+EFejE7LtUkO4bEh7BvSizVRRc6ajYByPOQ3sRsNrhbXRCA3dkhgyfAHPO8H/cCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982653; c=relaxed/simple;
	bh=LmduzRFItPDgKbL+UeUD/rgxc+BnpulsYzsA2Nv/lzQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RVPzPnLDbKTEIfyMpVW1TyOn2mZR8chfto83b+59htz+IOpz9QKWC0fg+g4fLZyrmZ3ryEbd5c95p94CYiymrpPKZp5dookX0Dq2QT0aevJCLNiE8qTIch285EbJGHcw4S+ndhM7k8+2Sujt8bLmqE0J5RmrYFzFYMUj2ZfgoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CZRaQm5Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8SdoCtJG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:04:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741982650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=se9bIRcMtv/3Qo/aKYKc0ZLfgUU/NIxO04/Tw05UCoY=;
	b=CZRaQm5QSt6QJs07g0ByiA0plkWdVbf6s5hl7BDNQBEyv7RUFwwBYCPNakMNJFQPxPQRB2
	2r+TCdc8ZA80zhVJKyStUb0FEzJcS5Id8FsuFBSsujKdQ8A0yNghWSmlaUgFjzm2feuqr+
	wCGuiqkvEyYCwqrHU2drO+bxnbZrRNtzmM0/7UdA7K9C4HGmRkq5lcL7DeRlyhqtOFNLlC
	VhnfLLmp1MS5UOC8L1P5BwyGtHuCPatOeWL+eqL1dIInR+0f631Byix46FjMa/u3tYEWnp
	Up7FGY103xEuU42FTlzz6OppC9BPv+y7WqmMrDC7uKnyG3ytt7aQi++3zkmfzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741982650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=se9bIRcMtv/3Qo/aKYKc0ZLfgUU/NIxO04/Tw05UCoY=;
	b=8SdoCtJGukLO9y0zXjFZVXPNRtRUbATvyVNAwXmrWGIYZPs/Z6jidObKjZTD47lgd41maA
	njB92qqwDJ8QaeBw==
From: "tip-bot2 for David Engraf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Hide unnecessary compiler error message
Cc: David Engraf <david.engraf@sysgo.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250203073610.206000-1-david.engraf@sysgo.com>
References: <20250203073610.206000-1-david.engraf@sysgo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198264454.14745.1315469641657975505.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     bf71940fc16953bed84caa59b7b076ead70d42f6
Gitweb:        https://git.kernel.org/tip/bf71940fc16953bed84caa59b7b076ead70d42f6
Author:        David Engraf <david.engraf@sysgo.com>
AuthorDate:    Mon, 03 Feb 2025 08:36:10 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 12 Mar 2025 15:43:38 -07:00

objtool: Hide unnecessary compiler error message

The check for using old libelf prints an error message when libelf.h is
not available but does not abort. This may confuse so hide the compiler
error message.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
Link: https://lore.kernel.org/r/20250203073610.206000-1-david.engraf@sysgo.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 7a65948..8c20361 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -37,7 +37,7 @@ OBJTOOL_CFLAGS := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBE
 OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
-elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(HOSTCC) $(OBJTOOL_CFLAGS) -x c -E - | grep elf_getshdr)
+elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(HOSTCC) $(OBJTOOL_CFLAGS) -x c -E - 2>/dev/null | grep elf_getshdr)
 OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 # Always want host compilation.

