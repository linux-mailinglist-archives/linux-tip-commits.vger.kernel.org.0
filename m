Return-Path: <linux-tip-commits+bounces-26-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA20581153B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Dec 2023 15:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C23F2820F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Dec 2023 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D32EAF7;
	Wed, 13 Dec 2023 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xMCS46Rk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XZ+HChB4"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3B993;
	Wed, 13 Dec 2023 06:51:02 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702479060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JHe6ZT6IqHXuvZfN2Kkv8LYZ39KD28BsElvHGdR2yLk=;
	b=xMCS46RkFqf5k2sd7I0D5MPvvAB63Omcbg8KLgVk2SQU7Ghd1CZw/ElA3/FOQt9X1UGnJn
	6U+4YO70gazL6yuOO8oelZ79FjJU6HDxDAqifYzSuEtPn3skyg0kJqCOEGOmX5bZqoQebL
	0VvVtQ/34lXz5afr0fWZWMYVBt4P1veJqfSC0Bodins7HhOHyETaQ9eXNzl1tUrCGxsbuR
	wl4HpmKpDljPQ6ZLzQmmxnPZOxb+n4i1Ia1Wl3GQZzuN8S39tpZv3TKuV4kCjv/mZPr8b8
	RBp7hXsGw+M3j83dEIXn4bmn9S6zM4KEQ7EOhOLSigCXc11Wx1096MrpFysiyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702479060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JHe6ZT6IqHXuvZfN2Kkv8LYZ39KD28BsElvHGdR2yLk=;
	b=XZ+HChB4RPHfbor4Q/YW7pwBZoCQviihzZCHu8++ftZ3wCiy3NX7Or9ivo25GQwo8/o5hP
	sapuqCrsi4G2GLCw==
To: "Zhang, Rui" <rui.zhang@intel.com>, "jsperbeck@google.com"
 <jsperbeck@google.com>, "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
Cc: "andres@anarazel.de" <andres@anarazel.de>, "peterz@infradead.org"
 <peterz@infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-tip-commits@vger.kernel.org"
 <linux-tip-commits@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
In-Reply-To: <c1d7e60329a62a9f6d70ffa664632db8db668efe.camel@intel.com>
References: <87ttonpbnr.ffs@tglx>
 <c1d7e60329a62a9f6d70ffa664632db8db668efe.camel@intel.com>
Date: Wed, 13 Dec 2023 15:51:00 +0100
Message-ID: <878r5yp357.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 13 2023 at 07:39, Zhang, Rui wrote:
> Yeah, I agree.
>
> I have posted a patch to do more strict check
> https://lore.kernel.org/all/20231210143925.38722-1-rui.zhang@intel.com/
> in case there are some weird cases that LAPIC fails to probe any
> enabled CPU and we also lose the X2APIC cpus.

The return value of acpi_register_lapic() is not really useful.

It returns an error if

  1) the number of registered CPUs reached the limit.
  2) the APIC entry is not enabled

#1: any further X2APIC CPU will be ignored

#2: the return value is bogus as the CPU is accounted for as disabled
    and will eventually lead to #1

    In fact even 'disabled' entries are valid as they can be brought
    in later (that's what "physical" hotplug uses)

The topology evaluation rework gets rid of this return value completely,
so I really don't want to add an dependency on it.

Thanks,

        tglx




