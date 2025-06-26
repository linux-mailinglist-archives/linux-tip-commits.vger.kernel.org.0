Return-Path: <linux-tip-commits+bounces-5923-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181CEAE9ED1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 15:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC93164B34
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBAE28BAAD;
	Thu, 26 Jun 2025 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jxj//Zy2"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AED136358
	for <linux-tip-commits@vger.kernel.org>; Thu, 26 Jun 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944726; cv=none; b=JKU0aULEtB32nAu5yKpKATKiNSVpFGu5EEezJWFvVnhr92FytihkBGmlCO+I5Uk4/29/hHkQpGerWc++n7p0Au2BK9UfK5a8TzkHB3hNT9thd7LY9M57pM118NROnJDKmqwP6im2lwt1KU23IEGDlDzgSflq0Ore4NVxaxEFthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944726; c=relaxed/simple;
	bh=AfPxERY5O1ODqtvE3jrBiWR4Wa3xTlBYcpIwRa/i1C4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KV4NU9uOWLCw9p4ioC0AsnZtyy4My/crJSpjH9NeNxZCe+feAywpEyRfR1sK9jhu+oLxJ1t9Vf40w8qAxPfwjz+njjfUrEoQSTku/VASjdxmC3nc0Dqv1dmmDCouSeTclVZnq+/d8rWofzbAnsJvG+BpldriRpIM2XBvTprLKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jxj//Zy2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31e1ef8890so648042a12.2
        for <linux-tip-commits@vger.kernel.org>; Thu, 26 Jun 2025 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750944724; x=1751549524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASrLckt86/ZNTRacVaov3vQ/UvbDNoBDf4mXFSO7YmE=;
        b=Jxj//Zy2L8P8zaFQyuha0cB3KsUq7TjdRSCHbEY0gLkT+DHS14bH/JGhkoLAZZB/up
         2ftKZGxjJ5+MOT9HKlIzGc8ePcUa50dSRGswvTKeyJvrW37iaIwfdkBRTeYKFARHYtKV
         +j8yobDr6cgmht2V18XXUgXL2Jy40bjg/CDcTzwb3uVi9EHBLs5CAizsYBLMRJh7/t8g
         BLH8AzKIWzOo0uw1VTbzlG6LCdZmH5nEbwk1ZqJm18gc0XTVPDZb62Nmu4THNPrUjpEC
         gxWzLK7PDacoZTlo/NTabay/I8oE1uoBmngXJC74lfPK4YpThvp4pExPoIFL/BIyOO4F
         BK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944724; x=1751549524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASrLckt86/ZNTRacVaov3vQ/UvbDNoBDf4mXFSO7YmE=;
        b=m0m+0pbT+Di9X+O4GgxzKBDA1g7dPXDUOWViYWnZCGoMBBh/DQg/3PpR03vjz+8dsq
         bdWeI15NULWaxH1q6/prD2unjHYNSVrQHWNXGtmnaK2N2+ICLm6OHAQIlD8iQq0NaD0o
         9IFyKy88GPeLf9XLzoYieWJadk8P16Ho+iBiNGbWhj8AG9JpLKzZxi/kCGzsKme/pCQM
         qW8tle8UoDTlJZpdTMqSMovR0KsNOs0tZvw0mE+4L6/tq0mrY/v6Ay45/zhTmU+lsrGt
         t/cklwE0KN/e/2uJugLGOF4b2/1JcvJZFayz3Yxpz/0tXNsmnJ9KzhdV67lh9FgoXUmD
         Ew+g==
X-Forwarded-Encrypted: i=1; AJvYcCW8fBjULGYGztIm1sa0rXPGvhOJQqGT4jX6Kn7tLjAH1TBqZJwhEOQ4wFKm10dcwtmlZTSyVrRTbxfM6hZ0W+naJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YypW8o5oOzVpGDyn9ybkKS+V6f67l5SIYhbkuzTXSY0JbncLwf7
	dV8DV3IlYXZAq0WDk1yIy4iKYx3xjH/tptXsV8ec5oLu07pEEiO6dwqF1VXhte2qrMYk6yhIBGS
	DmOJD0w==
X-Google-Smtp-Source: AGHT+IF9h4ysHLrlN9OOLpZXfLNb/gEg++gGgYd5FNTn15a550cl+YtJM7IYux7wvWO6MykGLBZMOCCwD08=
X-Received: from pfvf9.prod.google.com ([2002:a05:6a00:1ac9:b0:746:2e5d:3e6a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c887:b0:218:9b3e:e8bd
 with SMTP id adf61e73a8af0-2207f206609mr9914651637.10.1750944724309; Thu, 26
 Jun 2025 06:32:04 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:32:01 -0700
In-Reply-To: <20250626090439.GBaF0NJ34n065_4vb-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <175079732220.406.9335430223954818839.tip-bot2@tip-bot2> <20250626090439.GBaF0NJ34n065_4vb-@fat_crate.local>
Message-ID: <aF1L0fbNL6xE0C8d@google.com>
Subject: Re: [tip: x86/urgent] x86/traps: Initialize DR7 by writing its
 architectural reset value
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin (Intel)" <hpa@zytor.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 26, 2025, Borislav Petkov wrote:
> On Tue, Jun 24, 2025 at 08:35:22PM -0000, tip-bot2 for Xin Li (Intel) wrote:
> > The following commit has been merged into the x86/urgent branch of tip:
> > 
> > Commit-ID:     fa7d0f83c5c4223a01598876352473cb3d3bd4d7
> > Gitweb:        https://git.kernel.org/tip/fa7d0f83c5c4223a01598876352473cb3d3bd4d7
> > Author:        Xin Li (Intel) <xin@zytor.com>
> > AuthorDate:    Fri, 20 Jun 2025 16:15:04 -07:00
> > Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> > CommitterDate: Tue, 24 Jun 2025 13:15:52 -07:00
> > 
> > x86/traps: Initialize DR7 by writing its architectural reset value
> > 
> > Initialize DR7 by writing its architectural reset value to always set
> > bit 10, which is reserved to '1', when "clearing" DR7 so as not to
> > trigger unanticipated behavior if said bit is ever unreserved, e.g. as
> > a feature enabling flag with inverted polarity.
> 
> OMG, who wrote that "text"? 

I'm pretty sure I can take credit for the latter half.  You're welcome :-)

