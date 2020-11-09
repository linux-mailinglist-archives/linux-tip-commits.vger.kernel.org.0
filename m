Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A502AC8B1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Nov 2020 23:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgKIWgn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 9 Nov 2020 17:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIWgn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 9 Nov 2020 17:36:43 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD720C0613D3
        for <linux-tip-commits@vger.kernel.org>; Mon,  9 Nov 2020 14:36:41 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id k26so12072613oiw.0
        for <linux-tip-commits@vger.kernel.org>; Mon, 09 Nov 2020 14:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTh6EHdj/sEjVeEM7tTLdCGN17vFXhY30SLk5/K9tus=;
        b=DQepMCFhAe7e5wzfvOjHy+zSRqIgqviiVN86ZTuq+EjTL/Mjqv1OpUP/DhwbvqVXWt
         76jrPoQJBhQiAsIMEsumWsQ69zJmoKfDn+XzeIQbC7V9v/kcPPAOCAGzHdulH9SG77xX
         kA2zleK1xZmj/sADDwAzXXUeIL1Ht0tEFFO/RhzwcEs2ySi+sL23LWKiHjUJctMTcfZV
         zQf0bfsCwCfeP3brkU25GS2wehLX6WX52wLpctCDKAlLTgBX0yL0HpnPv9yZ94uvaqYy
         6a4TcSqhRT4gixWuZ4PA86TEB6/POnXjx8nx0X+PAfNhDQm071OPu9Iwx3qzuNL3G8jh
         9HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTh6EHdj/sEjVeEM7tTLdCGN17vFXhY30SLk5/K9tus=;
        b=M+6OjhwbL2EWWgQTn14EAF07335JTf/BGYEtkFzRh8dEBXqDAL8MkpVP6daKaNu9FA
         T5EjfEbPT6ehq5BJq6m7/sOVqcmU+d/pQdVwDbft6eKUaPtm6OAuUZDs0f4pXUxl8Lih
         /JD4/5ZHmG6hnLykiGLJUCs0BqkflPSdVb4zIn/OTti7prJ7t8z0LEjz4K76xA3WqjQU
         gKlziwNgm5/HhS4SmSgC63/2LWqk5SeHy3aoObmgPjmmTkLl8ByPqpX3R+IqD17+dfsw
         dPP4Vf+SD5OXGkIVQyEC+LB31q0EibCqfRDlU7WAEt7EXscUG3O1BRCF/N1647wfIUsH
         QwAg==
X-Gm-Message-State: AOAM531vvShq6cB05Vbwsc4H056puTNbQ5Mey08dudJSZTMvQjmuLKk6
        EICdivioLTD0rQ682wSZdGQLBlw9Zg/4c7NlU4BMAg==
X-Google-Smtp-Source: ABdhPJyGsZp34bN65P+ZviA1hv7Uw0zaa+Kw38+E6oue4vDWjH3T/+uur8iehxwmbCi7dDf59M+lS1szSQhCxNuYQeo=
X-Received: by 2002:a54:4082:: with SMTP id i2mr969744oii.28.1604961400870;
 Mon, 09 Nov 2020 14:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20201030190807.GA13884@agluck-desk2.amr.corp.intel.com>
 <160431588828.397.16468104725047768957.tip-bot2@tip-bot2> <3f863634cd75824907e8ccf8164548c2ef036f20.camel@redhat.com>
 <bfc274fc27724ea39ecac1e7ac834ed8@intel.com>
In-Reply-To: <bfc274fc27724ea39ecac1e7ac834ed8@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 9 Nov 2020 14:36:29 -0800
Message-ID: <CALMp9eTFaiYkTnVe8xKzg40E4nZ3rAOii0O06bTy0+oLNjyKhA@mail.gmail.com>
Subject: Re: [tip: ras/core] x86/mce: Enable additional error logging on
 certain Intel CPUs
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Qian Cai <cai@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>, Boris Petkov <bp@alien8.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Nov 9, 2020 at 2:09 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> What does KVM do with model specific MSRs?

"Model specific model-specific registers?" :-)

KVM only implements a small subset of MSRs. By default, any access to
the rest raises #GP.

> Looks like you let the guest believe it was running on one of Sandy Bridge, Ivy Bridge, Haswell (Xeon).
>
> So, the core MCE code tried to enable extended error reporting.
>
> If there is a mode to have KVM let the guest think that it read/wrote MSR 0x17F,
> but actually, doesn't do it ... that would seem to be a reasonable thing to do here.

There is an 'ignore_msrs' module parameter, to sink writes and return
zero on reads for unknown MSRs, but I don't think it's commonly used.

I thought Linux had long ago gone the route of turning rdmsr/wrmsr
into rdmsr_safe/wrmsr_safe, so that the guest would ignore the #GPs on
writes and return zero to the caller for #GPs on reads.
