Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32F71DCA41
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 May 2020 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgEUJiI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 May 2020 05:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgEUJiH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 May 2020 05:38:07 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC739C061A0F
        for <linux-tip-commits@vger.kernel.org>; Thu, 21 May 2020 02:38:07 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z6so1325000ooz.3
        for <linux-tip-commits@vger.kernel.org>; Thu, 21 May 2020 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRRenhNm9RcrMGaLaFDRHCMDiaKFzvbNFCQExEVcZEI=;
        b=HmNGNwT0/nTNwhk2QkQq2ieaY4fXPKzgGc6i93+BrNIwF1AtkKSu77TWtbfKwcwSc6
         dT/v4sy6DWT5wDaNmoJdoIAMrvhkxh2HNpgz8Hc2Vmu48egXDLCOqlFeI1mXEjLC/rb+
         APGPTYy2+DgT65Pc3waqCCRCvynp0Wbb3L5+UO+XfRz1RdirUXPJo9l8QPU4ylGmnxHp
         fJnleaCszpokXvQmkjyQuIjofri9zb8Pv2tjn3gaesbANbJzORgc/3wOTDWewar+37kF
         zlKDEVAHiOoKaaRAeVZZmW+ZKx7fqyCgVv6bS6xR9SGAr/PR/W8BIXM3MPItVGOW/6WM
         f72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRRenhNm9RcrMGaLaFDRHCMDiaKFzvbNFCQExEVcZEI=;
        b=IGo8q1DXkUdfrp6+r7lh/49x+/UcxnfiPDbfI0LN4ELiu9tpjrhvXr8ZQ2mkEELS3n
         p5jq11vHz93Dhex6NkG9Se+Q7C9Way0zn4JFdfuWUM+eKRImdjUyc/XF6zr0Z1f0J8wI
         tYVz1ptyIYcUMW40GJ3VeOl3rlVVZ+Le5Mus8sTpwwZOSO7lXrZOBF8ESSha/lRsjSrR
         oG2xE1iR5TAs//UH9eFCD5FNKsiKUNpGrySBdm7V2tlCVjpTd7omtWJN5C1DyPAgwIWI
         oUHpXyYA/IFJsaSGbG4TCor4q0zZW2q6CgiL+0Gbfhgq/JJFotuWO02IoZoYnWf4RYVb
         C6vQ==
X-Gm-Message-State: AOAM533tkqXdQ5nbNTsS/A4EH71SgWKIL4GAOsBx46wFqsYMR5FMnkWD
        T3k13SMCA9NOLZpxkN/bWKnAJFJDiCP0W8lBR0nZ2g==
X-Google-Smtp-Source: ABdhPJyw2BNtuFy9oINuCcU/aMPLnbDEf9QicF1fHmI3WsLhnZXh08jAfH1GiPiA2HkJL+Omfvf9ZHnVgwW65spkedY=
X-Received: by 2002:a4a:e836:: with SMTP id d22mr6691371ood.54.1590053886935;
 Thu, 21 May 2020 02:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-18-will@kernel.org> <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
 <20200520221712.GA21166@zn.tnic> <CANpmjNPsEMF8qq4qHoJEDb8mi211QzXODvnakh2fj3BOw+56MQ@mail.gmail.com>
 <20200521072557.GA10099@zn.tnic>
In-Reply-To: <20200521072557.GA10099@zn.tnic>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 11:37:54 +0200
Message-ID: <CANpmjNOJYWjhK3Z=mbbum8V8WzWOyfTWqz--+C3Z08LPCWm2Rw@mail.gmail.com>
Subject: Re: [tip: locking/kcsan] READ_ONCE: Use data_race() to avoid KCSAN instrumentation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, 21 May 2020 at 09:26, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, May 21, 2020 at 12:30:39AM +0200, Marco Elver wrote:
> > This should be fixed when the series that includes this commit is applied:
> > https://lore.kernel.org/lkml/20200515150338.190344-9-elver@google.com/
>
> Yap, that fixes it.
>
> Thx.

Thanks for confirming. I think Peter also mentioned that nested
statement expressions caused issues.

This probably also means we shouldn't have a nested "data_race()"
macro, to avoid any kind of nested statement expressions where
possible.

I will send a v2 of the above series to add that patch.

Thanks,
-- Marco
