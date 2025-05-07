Return-Path: <linux-tip-commits+bounces-5422-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B979BAAE0FC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FF81BC5BE7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C990B289816;
	Wed,  7 May 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xv2sLpZm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yGZW/tVx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17989289361;
	Wed,  7 May 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625450; cv=none; b=YYUkAfX3/VolQpovkJvL7En1EZOQiGdBLChIL59mAL/3jWhYW+trqclrFsf1HFBvkIWGbOvFftm7W8dRVfW7FqLCDQkGLzoCrhjsq3Rf69fjdOkK5fWoMgbUwhZdXGLxOu8qc449NpnZazbybxme0G4g5/QYNESYmVtPVw4DgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625450; c=relaxed/simple;
	bh=xpHFnghHDgGJkcrdKw2xpmbJxT2tngoh1vztQLGg43I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uYKV8YqifsTJrGqYeIsZ583nYrZiIYGVtJk2nCrFXc20YCA4ScTmsJWsmR9yNEBnmoOpQpWs7rJQmcinryzDwtujW4WzvW4xchofuIXaeieUAA1iu8xhw9UKibmrL10yUEqN6mLScMIsSelhZHAN/TZiSQSKsOSVt/0hlsttuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xv2sLpZm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yGZW/tVx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwejoj6GD7tJawgoj16JKwA3E6Na4cw1dd51bdnwO9Y=;
	b=xv2sLpZmDHglovIY5KUcOGNrMc9JO2PsNsIn4gbee0GZ7ba86oRCUW0W0j4WsEdANWIrj9
	NjNlnEjRrPPMiTN5F3SfhduDP+QOzK8OfqLYM7PzKjss0+OjhPtTxJU5gwTFp1emqwHFgQ
	w+H5kAIq2QXqN8mo6d75Vg3TgQjiNIKfMkVkXpjRxxhbd2XYedwZaGWDGnv1BJZ6wUWOh5
	K+Y34jTuzYB4dU9sDxUvBZOOtDsY0hDeOhSXKk4NOZUdXrAiJua7koStydibYLJI4KnYYz
	+VWubywwQhAvOIi1DtXxvENHg+ATx9uhieO0ygSRzxjOVX1Sp4RY8qJ5LCtNAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwejoj6GD7tJawgoj16JKwA3E6Na4cw1dd51bdnwO9Y=;
	b=yGZW/tVxD4Pqa7eeZTRqZIEnbl6YT/zO9olkS5xMfO087dI7L2UMVh0OeUH6A6Q2WXCtvt
	Qc8T0RLAkqaV8DCQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] Documentation: irq/concepts: Add commas and reflow
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-54-jirislaby@kernel.org>
References: <20250319092951.37667-54-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662544599.406.1181567000067766795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     55ec529a4e4189f7359d50f7c444e4a3589e2d12
Gitweb:        https://git.kernel.org/tip/55ec529a4e4189f7359d50f7c444e4a3589e2d12
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:42 +02:00

Documentation: irq/concepts: Add commas and reflow

For easier reading, it is always desired to add commas at some places in
text. Like before adverbs or after fronted sentences.

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-54-jirislaby@kernel.org


---
 Documentation/core-api/irq/concepts.rst | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-api/irq/concepts.rst b/Documentation/core-api/irq/concepts.rst
index 4273806..f166006 100644
--- a/Documentation/core-api/irq/concepts.rst
+++ b/Documentation/core-api/irq/concepts.rst
@@ -2,23 +2,22 @@
 What is an IRQ?
 ===============
 
-An IRQ is an interrupt request from a device.
-Currently they can come in over a pin, or over a packet.
-Several devices may be connected to the same pin thus
-sharing an IRQ.
+An IRQ is an interrupt request from a device. Currently, they can come
+in over a pin, or over a packet. Several devices may be connected to
+the same pin thus sharing an IRQ.
 
 An IRQ number is a kernel identifier used to talk about a hardware
-interrupt source.  Typically this is an index into the global irq_desc
-array, but except for what linux/interrupt.h implements the details
+interrupt source. Typically, this is an index into the global irq_desc
+array, but except for what linux/interrupt.h implements, the details
 are architecture specific.
 
 An IRQ number is an enumeration of the possible interrupt sources on a
-machine.  Typically what is enumerated is the number of input pins on
-all of the interrupt controller in the system.  In the case of ISA
+machine. Typically, what is enumerated is the number of input pins on
+all of the interrupt controllers in the system. In the case of ISA,
 what is enumerated are the 16 input pins on the two i8259 interrupt
 controllers.
 
 Architectures can assign additional meaning to the IRQ numbers, and
-are encouraged to in the case  where there is any manual configuration
-of the hardware involved.  The ISA IRQs are a classic example of
+are encouraged to in the case where there is any manual configuration
+of the hardware involved. The ISA IRQs are a classic example of
 assigning this kind of additional meaning.

