Return-Path: <linux-tip-commits+bounces-7772-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C31CACD06B4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Dec 2025 15:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19A543007C94
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Dec 2025 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D70E33A9D7;
	Fri, 19 Dec 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PK6J7tb"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491025DB12
	for <linux-tip-commits@vger.kernel.org>; Fri, 19 Dec 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156273; cv=none; b=icoF7Xs0FfPn35tHRurCbUv8TFLe3jYlxIDUEEdr/o0WTkrvbkuilK5xjjEWsCDAdUWHWIBMce2/sgA4j/rMn5G08SHvEDUsO9j4QhFoGLnAeEfgO8tqHQn9J+sBTwlqWyK2wiS/UbxUq9UwDLkII+/7/sRLQO5U3sAKigrLtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156273; c=relaxed/simple;
	bh=mkNqhV9WiF2+nf9rqKSXFDPOf031Yc4BX0YxsVb/OPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=szDU+P1XWxBlGsM1q2cp3IrgNro26VBYgiBcC8975Vxp0iwuAHUgSZH5Yb5na+4aFBEs1Vjq90Vp9oTc+BM/nBhBxt8YuhbLYzftzjGBA5vC4lYrGiD5oua62uT9ndSrR4p+/Flu/unQCMvaicc6P29SNGuSfvBlJPDgpybRQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PK6J7tb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c64cd48a8so4235014a91.0
        for <linux-tip-commits@vger.kernel.org>; Fri, 19 Dec 2025 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766156271; x=1766761071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MqWiCmNEH8alnJtLTveyyVgFFstQuw8nmjLVj/SWzc=;
        b=1PK6J7tbn/5Q8mxpbFh9UWGGwKtCPl/eQoZ2YZFZlhXSd4t89e/lOpQ/6wFBw0Dtt6
         /9VHa0XfCkbI1xidEQgteqzj6W2Z0/Zb1R8kbl2lf8Ye64O1LIl9t/RZW5YkEBbwPw6K
         fSfhj6nJtRgesqbOq0Mgih16ljN9wVV0aO09kJEAMDB7sOgxyfEz35Xyprju++DfcwDC
         H9sINGojWDeoTDNwdyG51saV5DgQoJ2cQ3QVIWbpsc7b/ttJd/v7XCi1YHe+uEpLxd3S
         fOwXSE6n6k2OFhD+4hQ2BAqrHUrvxdb0lQPU0xmllPr2bFqxg8zilndxEskIw4qfR+UW
         LzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766156271; x=1766761071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MqWiCmNEH8alnJtLTveyyVgFFstQuw8nmjLVj/SWzc=;
        b=OYI9CVcNlbnSL0XEhVpIl6yfV1qCGdV30tdWsO61VwDpDJEycaAoHOjOLH5TabdDaC
         1qNCJS/7f0Im/igCrFM0ds+mbdwusgakJ/xU5H0gQTHU/8P9w4QOZnfVHBozZ5dVwtbA
         VRAwv56KTBuYJGDG0xF908BMmkNw/727X3VwN1tAESuuBdf1rfjWAXGVl9amxvAI9r6n
         ABD+YN75jljaLXS6MZe8oBr39w/+SQZ/W7aNShXFtjDmcP4PjxfdF0wUoXJ8UgzY6X3e
         WhepL+CwBgUA3hC85RK+wiolLqYDlcaHNGn8IGDHYZEPh4d7MEEMaGJq7fXsPpmQHYpQ
         IivA==
X-Forwarded-Encrypted: i=1; AJvYcCV6oRyBo+ORo7bCOVxY8Kin26IsD4b4QRAxDKL7QA2HWr0OHhkriX35RGP3Oa3o/1mJwvrGoeScvBb7HHx4LXZLCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpTAxR3vLOKFGqOYLGy/s0wUTXplvm6LP6Zzzs/IVWLjttqjR
	guWdVD9N9dxDq69yydqSzj+d1hhkLNFbBZn6Js93/hGfpA5g/n7RmMs1r9jfZm3kp9wjn658fAk
	QB9ONTQ==
X-Google-Smtp-Source: AGHT+IFclvLPSA0J0AyfZYWwUmH36gc8jxESS4IFZSIxx6EqTt6mr/Mv/CYJlijNnMios0+N+Xc3g8I4Ank=
X-Received: from pjbst3.prod.google.com ([2002:a17:90b:1fc3:b0:34c:d9a0:3bf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c7:b0:32c:2cd:4d67
 with SMTP id 98e67ed59e1d1-34e92142bb2mr2492750a91.13.1766156271429; Fri, 19
 Dec 2025 06:57:51 -0800 (PST)
Date: Fri, 19 Dec 2025 06:57:50 -0800
In-Reply-To: <20251219075235.GV3911114@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251208115156.GE3707891@noisy.programming.kicks-ass.net>
 <176597507731.510.6380001909229389563.tip-bot2@tip-bot2> <20251218083109.GH3707891@noisy.programming.kicks-ass.net>
 <20251218083346.GG3708021@noisy.programming.kicks-ass.net>
 <aURKsxhxpJ0oHDok@google.com> <20251219075235.GV3911114@noisy.programming.kicks-ass.net>
Message-ID: <aUVn7tPw8EaJS-d7@google.com>
Subject: Re: [tip: perf/core] perf: Use EXPORT_SYMBOL_FOR_KVM() for the
 mediated APIs
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 19, 2025, Peter Zijlstra wrote:
> On Thu, Dec 18, 2025 at 10:40:51AM -0800, Sean Christopherson wrote:
> 
> 
> > Include the arch-defined asm/kvm_types.h if and only if the kernel is
> > being compiled for an architecture that supports KVM so that kvm_types.h
> > can be included in generic code without having to guard _those_ includes,
> > and without having to add "generic-y += kvm_types.h" for all architectures
> > that don't support KVM.
> 
> Something jogged my brain and the below seems to work for the few
> architectures I've tried. Let me update the patch and see if the build
> robot still finds fail.

Nice!  Works on my end as well.  Just when I think I've learned most of the
build system's tricks...

> ---
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 295c94a3ccc1..9aff61e7b8f2 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -32,6 +32,7 @@ mandatory-y += irq_work.h
>  mandatory-y += kdebug.h
>  mandatory-y += kmap_size.h
>  mandatory-y += kprobes.h
> +mandatory-y += kvm_types.h
>  mandatory-y += linkage.h
>  mandatory-y += local.h
>  mandatory-y += local64.h

