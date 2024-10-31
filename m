Return-Path: <linux-tip-commits+bounces-2682-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D263B9B8556
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 22:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027091C214BA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 21:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D2B1CDFCD;
	Thu, 31 Oct 2024 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vFi5kmaw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EpN49OLf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31FF1CCB27;
	Thu, 31 Oct 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410191; cv=none; b=FAyDep2sESe/I0RmDtGKBXH7cPU069xSyU4jeuBchpJOAQoxc4QK4tTztvUoY9WtnSbVNkXzj37TkXcVNbP2s9vbSm2f0Vcvx4PBKDe7dNr9WfxjaCRuabSMJqXR+D74vq0FgozAlAK3DQOraiYqftC13vKM1ltYN4hCoC/TOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410191; c=relaxed/simple;
	bh=owAgnNno4/xN6qOoLGi+tgKmvLVsT8n3b5AkzSBlenk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cPkmmp26F1Ffgv235xKGt4cpcQ033/RPHv87V2P4ztD8n0zOCZz3+ByIEPq8dV/2syD2RHWANl893Oag8ZpXoJDWreRQRz6/j2+DuTi5ZVtcp53X/UmLcX5YifFu2SL2zyTte+8ZLOVZMjV5t4k5BSRtLwQPPjIAc6OkAw+SNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vFi5kmaw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EpN49OLf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 21:29:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730410184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=b4sfY5VUQJ3sPQI2tTRxTdQHVhr8gJgnLG63k/oZNhs=;
	b=vFi5kmawKD6Ivk4f/EuHDKyrPR35+30LBpEBpH248pxx9A+jw5JfdzlzmfKcNApgtwdszU
	8oHy/W53GbeK6XfrhuZ/noFn4eGpPV/TFRxhcn3THEgXV4WLTa2QPww3VT3VsYrxp6hE1H
	6kel0AKzOb9xYRjB838EOVh8nm9m6Wb5B7dLuevGx8pl9Wgd9N6aj43SehEprwCZO96Jc8
	u6bEYyLNUvVeXCZ605FlhHnJTrW6Q0CvCvlIW7Gv6/EfD3DHIsOX7hWShuNiifhE+Ndlj7
	bUE9/wC1te7KkFWxXLtT3JNvavWG/jIpAgJhMSL/GMFc4zdPLo6D9hnFwb+jEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730410184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=b4sfY5VUQJ3sPQI2tTRxTdQHVhr8gJgnLG63k/oZNhs=;
	b=EpN49OLfeSPavMskpUDRLsWV+8m/ELYzhwgIj1AAl5k/GfZ74OMiBxxuAaXAn14z4G4exU
	Bv8JTbtc7YACXUCg==
From: "tip-bot2 for HONG Yifan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Also include tools/include/uapi
Cc: HONG Yifan <elsk@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173041018327.3137.9923437774880377307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     32b504854bd96f707a03c6ddecb0af9d7fbc4775
Gitweb:        https://git.kernel.org/tip/32b504854bd96f707a03c6ddecb0af9d7fbc4775
Author:        HONG Yifan <elsk@google.com>
AuthorDate:    Tue, 08 Oct 2024 23:47:17 
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 17 Oct 2024 15:13:06 -07:00

objtool: Also include tools/include/uapi

When building objtool against a sysroot that contains a stripped down
version of the UAPI headers, the following error happens:

    In file included from arch/x86/decode.c:10:
    In file included from .../tools/arch/x86/include/asm/insn.h:10:
    In file included from <sysroot>/include/asm/byteorder.h:9:
    In file included from <sysroot>/include/linux/byteorder/little_endian.h:15:
    In file included from <sysroot>/include/linux/stddef.h:9:
    In file included from .../tools/include/linux/compiler_types.h:36:
    .../tools/include/linux/compiler-gcc.h:3:2: error: "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
        3 | #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
        |  ^
    1 error generated.

As hinted by the error, this is because <sysroot>/include/linux/stddef.h
(a stripped-down version of uapi/include/linux/stddef.h) includes
linux/compiler_types.h directly. However, this gets resolved to
tools/include/linux/compiler_types.h, which is not expected to be
included directly.

To resolve this, I added tools/include/uapi to the include paths when
building objtool. With this trick, linux/stddef.h is resolved to
tools/include/uapi/linux/stddef.h, which doesn't include
linux/compiler_types.h.

Signed-off-by: HONG Yifan <elsk@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index bf7f7f8..f56e277 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -24,6 +24,7 @@ LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lel
 all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
+	    -I$(srctree)/tools/include/uapi \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
 	    -I$(srctree)/tools/objtool/include \

